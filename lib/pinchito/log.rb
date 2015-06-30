require "nokogiri"

module Pinchito
  class Log

    attr_reader :body, :title, :author, :date, :lines

    def self.from_id(id)
      Log.new(Pinchito::Client.get_log(id: id))
    end

    def initialize(body)
      @body = body
      parse
    end

    private

    def parse
      html_doc = Nokogiri::HTML(body)
      @title = extract_title(html_doc)
      @author = extract_author(html_doc)
      @date = extract_date(html_doc)
      @lines = extract_lines(html_doc)
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
      log_paragraph = html_doc.search(".logbody > p:nth-child(1)").first
      texts = log_paragraph.children.select{|n| n.is_a?(Nokogiri::XML::Text) }
        .map(&:text)
        .map(&:strip)
        .reject(&:empty?)
      users = log_paragraph.search(".nick").map(&:text)
      times = log_paragraph.search(".hora").map(&:text).map(&method(:parse_hour))
      texts.count.times.map do |i|
        {
          user: users[i],
          time: times[i],
          text: texts[i]
        }
      end
    end

    def author_line(html_doc)
      html_doc.search(".infolog").first.text
    end

    def parse_hour(text)
      hour_info = text.match(/\[(\d+):(\d+):(\d+)\]/)
      Time.new(@date.year, @date.month, @date.day, hour_info[1], hour_info[2], hour_info[3])
    end
  end
end
