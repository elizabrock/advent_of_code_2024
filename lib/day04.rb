class Day4
  def self.part1(input)
    Puzzle.new(input).XMAS_count
  end

  def self.part2(input)
    Puzzle.new(input).XedMAS_count
  end

  private

  class Puzzle
    def initialize(input)
      @grid = input.split(/\n/).map{|line| line.split(//)}
    end

    def XMAS_count
      locations_of('X').map{|x, y| XMAS_count_from_origin(x, y) }.sum
    end

    def XedMAS_count
      locations_of('A').map{|x, y| is_XedMAS_at_origin?(x, y) }.count(true)
    end

    private

    def is_XMAS?(x, m, a, s)
      x == 'X' and m == 'M' and a == 'A' and s == 'S'
    end

    def is_MAS?(m, a, s)
      m == 'M' and a == 'A' and s == 'S'
    end

    def get(x, y)
      return nil if x < 0 or x >= @grid.length
      return nil if y < 0 or y >= @grid[x].length
      @grid[x][y]
    end

    def locations_of(looking_for_char)
      locations = []
      @grid.each_with_index do |row, x|
        row.each_with_index do |char, y|
          if char == looking_for_char
            locations << [x, y]
          end
        end
      end
      locations
    end

    def XMAS_count_from_origin(x, y)
      nn = is_XMAS?(get(x, y), get(x-1, y  ), get(x-2, y  ), get(x-3, y  ))
      ne = is_XMAS?(get(x, y), get(x-1, y+1), get(x-2, y+2), get(x-3, y+3))
      ee = is_XMAS?(get(x, y), get(x  , y+1), get(x  , y+2), get(x  , y+3))
      se = is_XMAS?(get(x, y), get(x+1, y+1), get(x+2, y+2), get(x+3, y+3))
      ss = is_XMAS?(get(x, y), get(x+1, y  ), get(x+2, y  ), get(x+3, y  ))
      sw = is_XMAS?(get(x, y), get(x+1, y-1), get(x+2, y-2), get(x+3, y-3))
      ww = is_XMAS?(get(x, y), get(x  , y-1), get(  x, y-2), get(x  , y-3))
      nw = is_XMAS?(get(x, y), get(x-1, y-1), get(x-2, y-2), get(x-3, y-3))
      [nn, ne, ee, se, ss, sw, ww, nw].count(true)
    end

    def is_XedMAS_at_origin?(x, y)
      up_left = get(x-1, y-1)
      up_right = get(x+1, y-1)
      center = get(x, y)
      down_left = get(x-1, y+1)
      down_right = get(x+1, y+1)
      xedMAS_possibilities = [
        is_MAS?(up_left, center, down_right),
        is_MAS?(down_right, center, up_left),
        is_MAS?(up_right, center, down_left),
        is_MAS?(down_left, center, up_right)
      ]
      xedMAS_possibilities.count(true) >= 2
    end
  end
end
