lines = File.open('7.input').readlines.map(&:chomp)

splits = 0

p(
  lines[1..]
    .select { |l| l.include? '^' }
    .map { |l| l.chars.map { |c| c == '^' } }
    .inject(lines.first.chars.map { |c| c == 'S' ? 1 : 0 }) do |prev, l|
      n = Array.new(prev.length, 0)
      prev.each_with_index do |b, i|
        if b.positive?
          if l[i]
            splits += 1
            i != 0 && n[i - 1] += b
            i != l.length - 1 && n[i + 1] += b
          else
            n[i] += b
          end
        end
      end
    end
    .sum
)

p splits
