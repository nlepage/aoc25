input = File.open('5.input').read
split = input.split "\n\n"

ranges = split.first.split("\n").map { |l| l.split('-').map(&:to_i) }.map { |s, e| s..e }.uniq
ingredients = split.last.split("\n").map(&:to_i)

p(ingredients.count { |i| ranges.any? { |r| r.include? i } })

ranges = ranges.sort_by(&:end).sort_by(&:begin).inject([]) { |acc, a|
  if acc.empty?
    [a]
  elsif acc.last.cover?(a)
    acc
  elsif acc.last.include?(a.begin)
    [*acc[0...(acc.length - 1)], acc.last.begin..a.end]
  else
    [*acc, a]
  end
}

p ranges.map(&:size).sum
