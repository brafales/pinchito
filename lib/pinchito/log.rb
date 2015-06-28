require "nokogiri"

module Pinchito
  class Log

    attr_reader :body, :title, :author, :date, :lines

    def initialize(body)
      @body = body
      parse
    end

    private

    def parse
      html_doc = Nokogiri::HTML(body)
      extract_title(html_doc)
      extract_author(html_doc)
      extract_date(html_doc)
      extract_lines(html_doc)
    end

    def extract_title(html_doc)
      @title = html_doc.search(".titollog > a:nth-child(2)").first.text
    end

    def extract_author(html_doc)
      @author = author_line(html_doc).match(/Enviat per (.*)\./)[1]
    end

    def extract_date(html_doc)
      date_info = author_line(html_doc).match(/Log del (\d+)\/(\d+)\/(\d+)/)
      @date = Date.new(date_info[3].to_i, date_info[2].to_i, date_info[1].to_i)
    end

    def extract_lines(html_doc)
      log_paragraph = html_doc.search(".logbody > p:nth-child(1)").first
      @lines = log_paragraph.text
    end

    def author_line(html_doc)
      html_doc.search(".infolog").first.text
    end
  end
end
