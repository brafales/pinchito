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
        { user: "User1", text: "que diu que ell no està contaminat", time: Time.new(2007, 1, 10, 23, 13, 50) },
        { user: "User1", text: "diu: jo vaig començar amb amiga", time: Time.new(2007, 1, 10, 23, 13, 55) },
        { user: "User1", text: "i d'amiga vaig passar a linux", time: Time.new(2007, 1, 10, 23, 14, 01) },
        { user: "User1", text: "xD", time: Time.new(2007, 1, 10, 23, 14, 02) },
        { user: "User2", text: "hagues estat millor passar d'amiga a novia", time: Time.new(2007, 1, 10, 23, 14, 26) }
      ]
      @log.lines.must_equal lines
    end
  end

  describe '#to_s' do
    it "has a pretty format of the log" do
      pretty_log = <<EOL
LogTitle

23:13:42 - User1: conec un pavo
23:13:50 - User1: que diu que ell no està contaminat
23:13:55 - User1: diu: jo vaig començar amb amiga
23:14:01 - User1: i d'amiga vaig passar a linux
23:14:02 - User1: xD
23:14:26 - User2: hagues estat millor passar d'amiga a novia

Enviat el 10/01/2007 per User3
EOL

      @log.to_s.must_equal pretty_log.chomp
    end
  end
end
