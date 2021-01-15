require_relative 'db'
require_relative 'offspringXML'
require 'nokogiri'
require 'pry'

class Comparator
  def initialize
    @db = DB.new
  end

  def isEq(origin, offspring, ignored = [])
    @db.push(origin)
    doc = OffspringXML.new(@db.data[origin], ignored)
    parser = Nokogiri::XML::SAX::Parser.new(doc)
    parser.parse(File.open(offspring))

    res = doc.result
    return res if 'equal' == res
    "#{origin} has: #{res[:origin]}\n#{offspring} has: #{res[:offspring]}"
  end
end
