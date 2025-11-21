require_relative 'spec_helper'

# http://adventofcode.com/2024/day/11

describe Day11 do
  describe "part1" do
    it "overall scenario" do
      expected = 55312
      actual = Day11.part1('125 17')
      _(actual).must_equal(expected)
    end
  end

  describe "part2" do
    it "overall scenario" do
      expected = 65601038650482
      actual = Day11.part2('125 17')
      _(actual).must_equal(expected)
    end
  end

  describe Day11::PhysicsDefyingStones do
    describe "#count_after_rapid_blinks" do
      let(:state0){ Day11::PhysicsDefyingStones.new("125 17") }
      let(:state1){ Day11::PhysicsDefyingStones.new("253000 1 7") }
      let(:state2){ Day11::PhysicsDefyingStones.new("253 0 2024 14168") }
      let(:state3){ Day11::PhysicsDefyingStones.new("512072 1 20 24 28676032") }
      let(:state4){ Day11::PhysicsDefyingStones.new("512 72 2024 2 0 2 4 2867 6032") }
      let(:state5){ Day11::PhysicsDefyingStones.new("1036288 7 2 20 24 4048 1 4048 8096 28 67 60 32") }
      let(:state6){ Day11::PhysicsDefyingStones.new("2097446912 14168 4048 2 0 2 4 40 48 2024 40 48 80 96 2 8 6 7 6 0 3 2") }
      it 'transitions from state 0 to state 1' do
        actual = state0.count_after_rapid_blinks
        _(actual).must_equal(state1.count)
      end

      it 'transitions from state 1 to state 2' do
        actual = state1.count_after_rapid_blinks
        _(actual).must_equal(state2.count)
      end

      it 'transitions from state 2 to state 3' do
        actual = state2.count_after_rapid_blinks
        _(actual).must_equal(state3.count)
      end

      it 'transitions from state 3 to state 4' do
        actual = state3.count_after_rapid_blinks
        _(actual).must_equal(state4.count)
      end

      it 'transitions from state 4 to state 5' do
        actual = state4.count_after_rapid_blinks
        _(actual).must_equal(state5.count)
      end

      it 'transitions from state 5 to state 6' do
        actual = state5.count_after_rapid_blinks
        _(actual).must_equal(state6.count)
      end

      it 'transitions from initial state all the way through' do
        stones = Day11::PhysicsDefyingStones.new("125 17")
        actual = stones.count_after_rapid_blinks(6)
        _(actual).must_equal(state6.count)
      end

      describe "caching precalculated results" do
        def get_cached_result_for(stone, generations)
          Day11::PhysicsDefyingStones.descendant_counts_for(stone, through_at_least: generations, fill_in_cache_misses: false)[generations-1]
        end

        before do
          stones = Day11::PhysicsDefyingStones.new("125 17 17")
          # 17 -> 1 7 -> 2024 14168 -> 20 24 28676032 -> 2 0 2 4 2867 6032
          #   -> 2 -> 2 -> 3 -> 6
          stones.count_after_rapid_blinks(4)
        end

        it 'caches interim (1) results cached from #count_after_rapid_blinks' do
          expected = 2
          actual = get_cached_result_for(17, 1)
          _(actual).must_equal(expected)
        end

        it 'caches interim (2) results cached from #count_after_rapid_blinks' do
          expected = 2
          actual = get_cached_result_for(17, 2)
          _(actual).must_equal(expected)
        end

        it 'caches interim (3) results cached from #count_after_rapid_blinks' do
          expected = 3
          actual = get_cached_result_for(17, 3)
          _(actual).must_equal(expected)
        end

        it 'caches final results cached from #count_after_rapid_blinks' do
          expected = 6
          actual = get_cached_result_for(17, 4)
          _(actual).must_equal(expected)
        end
      end
    end

    describe "#count" do
      it 'returns the number of items in the list' do
        stones = Day11::PhysicsDefyingStones.new("2097446912 14168 4048 2 0 2 4 40 48 2024 40 48 80 96 2 8 6 7 6 0 3 2")
        expected = 22
        _(stones.count).must_equal(expected)
      end
    end
  end
end
