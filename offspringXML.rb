require 'digest'
require 'json'
require 'nokogiri'
require 'pry'

class OffspringXML < Nokogiri::XML::SAX::Document
  attr_accessor :origin

  def initialize(origin, ignored)
    @origin = origin.clone
    @ignored = ignored
    @index = 0
    @path = []
    @items = []
    @diff = {origin: [], offspring: []}
  end

  def start_element name, _attrs = []
    @index += 1
    @path.push(name)
    @key = @path.join('/')
    if 0 == _attrs.length
      @items[@index] = {}
      return
    end
    attrs = _attrs.sort_by { |e| e[0] }

    @items[@index] = {
      'attrs' => attrs,
      'digest' => Digest::MD5.hexdigest(attrs.to_json)
    }
  end

  def characters(text)
    @items[@index]['characters'] = text.strip
  end

  def compare
    if @origin.key?(@key)
      i = @origin[@key].index(@items[@index])
      @origin[@key].delete_at(i) if i
      @diff[:offspring].push(["xpath: #{@key}", @items[@index]]) if !i
      @origin.delete(@key) if 0 == @origin[@key].length
    end
  end

  def end_element name
    compare if !@ignored.index(@key)

    @path.pop
    @key = @path.join('/')
    @index -= 1
  end

  def result
    # binding.pry
    # @diff
    @origin.each_pair do |key, value|
      next if !@ignored.index(@key)
      @diff[:origin].push(["xpath #{key}", value])
    end

    return 'equal' if @diff[:origin].empty? && @diff[:offspring].empty?
    # binding.pry
    @diff
  end
end
