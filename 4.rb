around = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

lines = File.open('4.input').readlines.map(&:chomp)

rolls = lines.map { |l| l.each_char.map { |c| c == '@' } }

h = rolls.length
w = rolls.first.length

p rolls.each_with_index.map { |l, y|
  l.each_with_index
    .select { |r, _| r }
    .select { |_, x| around.map { |ay, ax| [y + ay, x + ax] }.select { |y, x| y >= 0 && y < h && x >= 0 && x < w }.select { |y, x| rolls[y][x] }.length < 4 }
    .length
}.sum

r = 0

loop do
  removables = rolls.each_with_index.map { |l, y|
    l.each_with_index
      .select { |r, _| r }
      .map { |_, x| x }
      .select { |x| around.map { |ay, ax| [y + ay, x + ax] }.select { |y, x| y >= 0 && y < h && x >= 0 && x < w }.select { |y, x| rolls[y][x] }.length < 4 }
      .map { |x| [y, x] }
  }.flatten(1)

  if removables.empty?
    break
  end

  removables.each { |y, x| rolls[y][x] = false }
  r += removables.length
end

p r
