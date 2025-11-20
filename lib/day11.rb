class Day11
  def self.part1(input)
    stones = PhysicsDefyingStones.new(input)
    25.times{ stones.blink! }
    stones.count
  end

  def self.part2(input)
    "TBD"
  end

  class PhysicsDefyingStones
    include Enumerable

    def initialize(input)
      input.split(" ").inject(nil) do |previous, value|
        next_stone = PhysicsDefyingStone.new(value.to_i)
        if previous
          previous.next = next_stone
        else
          @first = next_stone
        end
        next_stone
      end
    end

    def blink!
      reverse_each(&:blink!)
    end

    def each(&block)
      node = @first
      while node
        block.call(node)
        node = node.next
      end
    end

    def inspect
      "#<PhysicsDefyingStones #{to_s}>"
    end

    def to_s
      map(&:to_s).join(" ")
    end

    def ==(other)
      return false unless other.is_a? PhysicsDefyingStones
      node_a = @first
      node_b = other.first
      while node_a
        return false unless node_a == node_b
        node_a = node_a.next
        node_b = node_b.next
      end
      return false if node_b
      true
    end

    private

    class PhysicsDefyingStone
      attr_accessor :next
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def blink!
        digits = @value.to_s

        if @value == 0
          # If the stone is engraved with the number 0, it is replaced by a stone engraved
          # with the number 1.
          @value = 1
        elsif digits.length.even?
          # If the stone is engraved with a number that has an even number of digits, it is
          # replaced by two stones. The left half of the digits are engraved on the new left
          # stone, and the right half of the digits are engraved on the new right stone. (The
          # new numbers don't keep extra leading zeroes: 1000 would become stones 10 and 0.)
          @value = digits.slice!(0...digits.length/2).to_i
          new_stone = PhysicsDefyingStone.new(digits.to_i)
          new_stone.next = self.next
          self.next = new_stone
          return
        else
          # If none of the other rules apply, the stone is replaced by a new stone; the old
          # stone's number multiplied by 2024 is engraved on the new stone.
          @value *= 2024
        end
      end

      def to_s
        @value.to_s
      end

      def ==(other)
        return false unless other.is_a? PhysicsDefyingStone
        self.value == other.value
      end
    end
  end
end
