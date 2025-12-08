lines = File.open('8.input').readlines.map(&:chomp)

Coords = lines.map { |l| l.split(',').map(&:to_i) }

def d(coord1, coord2)
  (coord1[0] - coord2[0])**2 + (coord1[1] - coord2[1])**2 + (coord1[2] - coord2[2])**2
end

p(
  Coords
    .combination(2)
    .sort_by { |c1, c2| d(c1, c2) }
    .first(1000)
    .inject([]) do |circuits, coords|
      matches, rest = circuits.partition { |circuit| circuit.include?(coords[0]) || circuit.include?(coords[1]) }
      [*rest, (matches.flatten(1) + coords).uniq]
    end
    .map(&:size)
    .sort
    .reverse
    .first(3)
    .inject(&:*)
)

p(
  Coords
    .combination(2)
    .sort_by { |c1, c2| d(c1, c2) }
    .inject([]) do |circuits, coords|
      matches, rest = circuits.partition { |circuit| circuit.include?(coords[0]) || circuit.include?(coords[1]) }
      result = [*rest, (matches.flatten(1) + coords).uniq]
      result.length == 1 && result[0].length == Coords.length && break coords[0][0] * coords[1][0]
      result
    end
)
