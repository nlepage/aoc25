lines = File.open('11.input').readlines.map(&:chomp)

devices = lines.map do |l|
  input, rest = l.split(': ')
  [input, rest.split]
end.to_h

def count(start, target, devices)
  in_ways = Set[target]
  nexts = [start]

  until nexts.empty?
    devices[nexts.shift]&.each do |device|
      next if in_ways.include? device

      in_ways << device
      nexts << device
    end
  end

  rdevices = in_ways.to_h { |device| [device, []] }
  devices
    .select { |device, _| device == start || in_ways.include?(device) }
    .each { |device, outputs| outputs.each { |output| rdevices[output]&.push device } }

  ways = {}
  ways[start] = 1
  nexts = in_ways.to_a

  until nexts.empty?
    device = nexts.find { |device| rdevices[device].all? { |input| ways.include? input } }
    nexts.delete device

    ways[device] = rdevices[device].map { |input| ways[input] }.sum
  end

  ways[target]
end

p count('you', 'out', devices)

p count('svr', 'fft', devices) * count('fft', 'dac', devices) * count('dac', 'out', devices)
