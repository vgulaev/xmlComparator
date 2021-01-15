require 'digest'
require 'json'
require 'nokogiri'

class DBImport < Nokogiri::XML::SAX::Document
  attr_accessor :data

  def initialize
    @path = []
    @data = {}
    @items = []
    @index = -1
  end

  def start_element name, _attrs = []
    @index += 1
    # p "start_element index #{@index}"
    @path.push(name)
    @key = @path.join('/')
    @data[@key] = [] if !@data.key?(@key)
    if 0 == _attrs.length
      @items[@index] = {}
      return
    end
    attrs = _attrs.sort_by { |e| e[0] }

    @items[@index] = {
      attrs: attrs,
      digest: Digest::MD5.hexdigest(attrs.to_json)
    }
  end

  def characters(text)
    # p "characters index #{@index} *** #{text}"
    @items[@index]['characters'] = text.strip
  end

  def end_element name
    # p "end_element index #{@index}"
    @data[@key].push(@items[@index])
    @path.pop
    @key = @path.join('/')
    @index -= 1
  end
end
