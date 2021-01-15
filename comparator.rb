require_relative 'db'

class Comparator
  def initialize
    @db = DB.new
  end

  def isEq(original, spring, ignored = [])
    @db.push(original)
    p original
  end
end
