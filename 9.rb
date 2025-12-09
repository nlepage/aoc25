lines = File.open('9.input').readlines.map(&:chomp)

coords = lines.map { |l| l.split(',').map!(&:to_i) }

combs = coords.combination(2)

p(combs.map { |c1, c2| ((c2[0] - c1[0]).abs + 1) * ((c2[1] - c1[1]).abs + 1) }.max)

vwalls = []

(coords + [coords.first]).each_cons(2) do |coords|
  c1, c2 = coords.sort
  if c1[1] == c2[1]
    vwalls[c1[1]] ||= []
    vwalls[c1[1]] << (c1[0]..c2[0])
  else
    ((c1[1] + 1)...c2[1]).each do |y|
      vwalls[y] ||= []
      vwalls[y] << (c1[0]..c1[0])
    end
  end
end

vin = vwalls
      .each_with_index
      .map do |l, y|
        inside = false
        l&.sort_by(&:begin)&.inject([]) do |acc, w|
          pinside = inside
          if w.size == 1 || vwalls[y - 1] && vwalls[y - 1].any? { |pw| pw.size == 1 && pw.include?(w.begin) } != vwalls[y - 1].any? { |pw| pw.size == 1 && pw.include?(w.end) }
            inside = !inside
          end
          if pinside
            acc.last << w
            acc
          else
            [*acc, [w]]
          end
        end
      end
      .map { |l| l&.map { |c| c.first.begin..c.last.end } }

vout = vin.map { |l| l ? [..-1, *l, 100_000..].each_cons(2).map { |in1, in2| (in1.end + 1)..(in2.begin - 1) } : [0..99_999] }

outs = vout
       .each_with_index
       .flat_map { |l, y| l.map { |c| [c, y] } }
       .sort_by! { |c, y| c.begin * 10_000_000_000 + c.end * 100_000 + y }
       .chunk_while { |c1, c2| c1[0] == c2[0] && c1[1] + 1 == c2[1] }
       .map { |g| [g.first.first, g.first.last..g.last.last] }

p(
  combs
    .reject do |c1, c2|
      x = c1[0] < c2[0] ? c1[0]..c2[0] : c2[0]..c1[0]
      y = c1[1] < c2[1] ? c1[1]..c2[1] : c2[1]..c1[1]
      outs.any? do |sx, sy|
        (
          sx.include?(x.begin) ||
          sx.include?(x.end) ||
          x.include?(sx.begin) ||
          x.include?(sx.end)
        ) && (
          sy.include?(y.begin) ||
          sy.include?(y.end) ||
          y.include?(sy.begin) ||
          y.include?(sy.end)
        )
      end
    end
    .map { |c1, c2| ((c2[0] - c1[0]).abs + 1) * ((c2[1] - c1[1]).abs + 1) }
    .max
)
