require_relative 'comparator'

cmp = Comparator.new()

r = cmp.isEq('DataExamples/1.xml', 'DataExamples/2.xml', ['bpmn2:definitions/bpmn2:process/aaa'])
# r = cmp.isEq('DataExamples/11.xml', 'DataExamples/11.xml')
# r = cmp.isEq('DataExamples/111.xml', 'DataExamples/222.xml')

puts r
p 'Hello'
