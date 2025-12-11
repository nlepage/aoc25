lines = File.open('11.input').readlines.map(&:chomp)

devices = lines.map do |l|
  input, rest = l.split(': ')
  [input, rest.split]
end.to_h

inputs = ['you']
r = 0
until inputs.empty?
  input = inputs.pop
  outputs = devices[input]
  if outputs.first == 'out'
    r += 1
    next
  end
  inputs.push(*outputs)
end

p r
