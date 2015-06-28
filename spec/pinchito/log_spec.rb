require 'spec_helper'

describe Pinchito::Log do
  before do
    @log_contents = File.read('spec/support/fixtures/logs/log_1.html')
    @log = Pinchito::Log.new(@log_contents)
  end

  describe "#body" do
    it "has the file contents" do
      @log.body.must_equal @log_contents
    end
  end

  describe "#title" do
    it "has the title" do
      @log.title.must_equal "LogTitle"
    end
  end

  describe "#author" do
    it "has the author" do
      @log.author.must_equal "User3"
    end
  end

  describe "#date" do
    it "has the date" do
      @log.date.must_equal Date.new(2007, 1, 10)
    end
  end

  describe "#lines" do
    it "has the log contents" do
      lines = [
        { user: "User1", text: "conec un pavo", time: Time.new(2007, 1, 10, 23, 13, 42) },
        { user: "User1", text: "que diu que ell no està contaminat", time: Time.new(2007, 1, 10, 23, 13, 42) },
        { user: "User1", text: "diu: jo vaig començar amb amiga", time: Time.new(2007, 1, 10, 23, 13, 50) },
        { user: "User1", text: "i d'amiga vaig passar a linux", time: Time.new(2007, 1, 10, 23, 14, 01) },
        { user: "User1", text: "xD", time: Time.new(2007, 1, 10, 23, 14, 02) },
        { user: "User2", text: "hagues estat millor passar d'amiga a novia", time: Time.new(2007, 1, 10, 23, 14, 26) }
      ]
      @log.lines.must_equal lines
    end
  end
end
