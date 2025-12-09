lines = File.open('1.input').readlines.map(&:chomp)

moves = lines.map { |l| (l[0] == 'L' ? -1 : 1) * l[1..].to_i }

d = 50
stops = moves.map { |m| d = (d + m) % 100 }
p stops.count 0

d = 50
stops = 0
moves.each do |m|
  nd = d + m
  s = m / m.abs
  stops += ((d + s)..nd).step(s).count { |x| (x % 100).zero? }
  d = nd
end
p stops
