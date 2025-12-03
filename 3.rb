lines = File.open('3.input').readlines.map(&:chomp)

batteries = lines.map { |l| l.each_char.map(&:to_i) }

def solve(batteries, size)
  p batteries.map { |digits|
    s = 0
    ((digits.length - size)...digits.length).map { |e|
      d = digits[s..e].each_with_index.inject { |a, b| b[0] > a[0] ? b : a }
      s += d[1] + 1
      d[0]
    }.join.to_i
  }.sum
end

solve(batteries, 2)
solve(batteries, 12)
