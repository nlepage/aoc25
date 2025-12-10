lines = File.open('10.input').readlines.map(&:chomp)

machines = lines.map(&:split).map do |arr|
  lights = arr.first[1..-2].tr('.#', '01').to_i(2)
  buttons = arr[1..-2].map { |s| s[1..-2].split(',').map { |c| 2**(arr.first.length - c.to_i - 3) }.sum }
  [lights, buttons]
end

p(machines.map do |lights, buttons|
  clights = [[0, buttons]]

  until clights.any? { |v, _| v == lights }
    clights = clights.flat_map do |lights, buttons|
      buttons.map { |button| [lights ^ button, buttons - [button]] }
    end.uniq
  end

  buttons.length - clights.find { |v, _| v == lights }.last.length
end.sum)
