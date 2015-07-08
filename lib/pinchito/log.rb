require "nokogiri"

module Pinchito
  class Log

    DATE_FORMAT = "%d/%m/%Y"
    TIME_FORMAT = "%H:%M:%S"

    attr_reader :body, :title, :author, :date, :lines

    def self.from_id(id)
      Log.new(Pinchito::Client.get_log(id: id))
    end

    def self.from_search(query)
      Log.new(Pinchito::Client.search_log(query: query))
    end

    def self.from_tapeta
      Log.new(Pinchito::Client.tapeta)
    end

    def initialize(body)
      @body = body
      parse
    end

    def to_s
      [
        title,
        "",
        lines,
        "",
        date_line,
      ].join("\n").scrub
    end

    private

    def date_line
      "Enviat el #{pretty_date(date)} per #{author}"
    end

    def pretty_date(date)
      date.strftime(DATE_FORMAT)
    end

    def pretty_time(datetime)
      datetime.strftime(TIME_FORMAT)
    end

    def parse
      html_doc = Nokogiri::HTML(body)
      enforce_log(html_doc)
      @title = extract_title(html_doc)
      @author = extract_author(html_doc)
      @date = extract_date(html_doc)
      @lines = extract_lines(html_doc)
    end

    def enforce_log(html_doc)
      log = html_doc.search("div.log")
      if log.empty?
        raise Pinchito::LogNotFound
      end
    end

    def extract_title(html_doc)
      html_doc.search(".titollog > a:nth-child(2)").first.text
    end

    def extract_author(html_doc)
      author_line(html_doc).match(/Enviat per (.*)\./)[1]
    end

    def extract_date(html_doc)
      date_info = author_line(html_doc).match(/Log del (\d+)\/(\d+)\/(\d+)/)
      Date.new(date_info[3].to_i, date_info[2].to_i, date_info[1].to_i)
    end

    def extract_lines(html_doc)
      html_doc.search(".logbody > p:nth-child(1)").first.text
    end

    def author_line(html_doc)
      html_doc.search(".infolog").first.text
    end

    def parse_hour(text)
      hour_info = text.match(/\[(\d+)?:?(\d+)?:?(\d+)?\]/)
      Time.new(@date.year, @date.month, @date.day, hour_info[1].to_i, hour_info[2].to_i, hour_info[3].to_i)
    end
  end
end
