input = File.open('2.input').read

ranges = input.split(',').map { |s| s.split('-').map(&:to_i) }.map { |s, e| Range.new(s, e) }

p(ranges.sum { |r| r.select { |i| s = i.to_s; s.length.even? && s[0...(s.length / 2)] == s[(s.length / 2)..s.length] }.sum })

divisors = [[], [], [1], [1], [1, 2], [1], [1, 2, 3], [1], [1, 2, 4], [1, 3], [1, 2, 5]]
p(ranges.sum { |r| r.select { |i| s = i.to_s; divisors[s.length].any? { |d| s[0...d] * (s.length / d) == s } }.sum })
