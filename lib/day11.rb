class Day11
  def self.part1(input)
    stones = PhysicsDefyingStones.new(input)
    stones.count_after_rapid_blinks(25)
  end

  def self.part2(input)
    stones = PhysicsDefyingStones.new(input)
    stones.count_after_rapid_blinks(75)
  end

  class PhysicsDefyingStones
    @@cache = {}
    attr_reader :stones

    def initialize(input)
      @stones = input.split(" ").map(&:to_i)
      @precalculated_results = {}
    end

    def count_after_rapid_blinks(n=1)
      @stones.sum{ |stone| self.class.descendant_count(for_stone: stone, at_generation: n) }
    end

    def count
      @stones.count
    end

    private

    def self.calculate_descendant_counts(stone, generations)
      return unless generations > 0

      next_generation = immediate_descendants_for(stone)
      if generations > 1
        results = coalesce_descendant_counts_for(next_generation, generations - 1)
      else
        results = []
      end
      results.unshift next_generation.count

      results
    end

    def self.coalesce_descendant_counts_for(list, generations)
      lists_of_descendant_counts = list.map{ |i| descendant_counts_for(i, through_at_least: generations) }
      results = []
      (Array.new(generations, 0)).zip(*lists_of_descendant_counts){ |sub_array| results << sub_array.sum }
      results
    end

    def self.descendant_count(for_stone: nil, at_generation: nil)
      cache_hit = descendant_counts_for(for_stone, through_at_least: at_generation)
      cache_hit[at_generation - 1]
    end

    def self.descendant_counts_for(stone, through_at_least: 1, fill_in_cache_misses: true)
      unless @@cache.has_key?(stone) && @@cache[stone].length >= through_at_least
        if fill_in_cache_misses
          @@cache[stone] = PhysicsDefyingStones::calculate_descendant_counts(stone, through_at_least)
        end
      end

      @@cache[stone]
    end

    def self.immediate_descendants_for(i)
      # If the stone is engraved with the number 0, it is replaced by a stone engraved
      # with the number 1.
      return [ 1 ] if i == 0

      digits = i.to_s
      if digits.length.even?
        # If the stone is engraved with a number that has an even number of digits, it is
        # replaced by two stones. The left half of the digits are engraved on the new left
        # stone, and the right half of the digits are engraved on the new right stone. (The
        # new numbers don't keep extra leading zeroes: 1000 would become stones 10 and 0.)
        [ digits.slice!(0...digits.length/2).to_i, digits.to_i ]
      else
        # If none of the other rules apply, the stone is replaced by a new stone; the old
        # stone's number multiplied by 2024 is engraved on the new stone.
        [ i * 2024 ]
      end
    end
  end
end
