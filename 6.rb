lines = File.open('6.input').readlines.map(&:chomp)

p(lines.map(&:split).transpose.map { |p|
  n = p[0..-2].map(&:to_i)
  p.last == '+' ? n.inject(&:+) : n.inject(&:*)
}.sum)

operators = lines.last.split
p(
  lines[0..-2]
    .map(&:chars)
    .transpose
    .map(&:join)
    .map(&:to_i)
    .chunk_while { |n| !n.zero? }
    .map { |c| c.reject(&:zero?) }
    .each_with_index
    .map { |n, i| operators[i] == '+' ? n.inject(&:+) : n.inject(&:*) }
    .sum
)
