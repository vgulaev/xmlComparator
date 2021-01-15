require 'nokogiri'
require 'json'
require_relative 'dbImport'

class DB
  def initialize
    @root = 'tmp'
    @data = {}
    Dir.mkdir @root if !File.directory?(@root)
  end

  def update(fileName, dbName)
    doc = DBImport.new
    parser = Nokogiri::XML::SAX::Parser.new(doc)
    parser.parse(File.open(fileName))
    File.open(dbName, "w") { |file| file.write(JSON.pretty_generate(doc.data)) }
  end

  def push(fileName)
    basename = File.basename(fileName, '.xml')
    dbName = "#{@root}/#{basename}.json"
    update(fileName, dbName) # if !File.exists?(dbName)
    @data = {"#{fileName}": JSON.parse(File.read(dbName))} if @data.key?(fileName)
  end
end
