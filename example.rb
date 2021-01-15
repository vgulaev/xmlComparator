require_relative 'comparator'

cmp = Comparator.new()

# r = cmp.isEq('DataExamples/1.xml', 'DataExamples/2.xml')
r = cmp.isEq('DataExamples/11.xml', 'DataExamples/2.xml')
# r = cmp.isEq('DataExamples/111.xml', 'DataExamples/2.xml')

p 'Hello'
p r
