require_relative 'spec_helper'

# http://adventofcode.com/2024/day/7

describe Day7 do
  let(:input) {
    <<~STRING
      190: 10 19
      3267: 81 40 27
      83: 17 5
      156: 15 6
      7290: 6 8 6 15
      161011: 16 10 13
      192: 17 8 14
      21037: 9 7 18 13
      292: 11 6 16 20
    STRING
  }

  describe "part1" do
    it "overall scenario" do
      expected = 3749
      actual = Day7.part1(input)
      _(actual).must_equal(expected)
    end
  end

  describe Day7::CalibrationEquation do
    describe "solvable?" do
      it "is true for solvable example 1" do
        assert Day7::CalibrationEquation.new(190, [10, 19]).solvable?
      end
      it "is true for solvable example 2" do
        assert Day7::CalibrationEquation.new(3267, [81, 40, 27]).solvable?
      end
      it "is true for solvable example 3" do
        assert Day7::CalibrationEquation.new(292, [11, 6, 16, 20]).solvable?
      end
      it "is false for unsolvable example 1" do
        refute Day7::CalibrationEquation.new(156, [15, 6]).solvable?
      end
      it "is false for unsolvable example 2" do
        refute Day7::CalibrationEquation.new(7290, [6, 8, 6, 15]).solvable?
      end
      it "is false for unsolvable example 3" do
        refute Day7::CalibrationEquation.new(161011, [16, 10, 13]).solvable?
      end
      describe "with concatenation" do
        it "is true for solvable example 1" do
          equation = Day7::CalibrationEquation.new(190, [10, 19])
          equation.enable_concatentation!
          assert equation.solvable?
        end
        it "is true for solvable example 2" do
          equation = Day7::CalibrationEquation.new(3267, [81, 40, 27])
          equation.enable_concatentation!
          assert equation.solvable?
        end
        it "is true for solvable example 3" do
          equation = Day7::CalibrationEquation.new(292, [11, 6, 16, 20])
          equation.enable_concatentation!
          assert equation.solvable?
        end
        it "is true for newly solvable example 1" do
          equation = Day7::CalibrationEquation.new(156, [15, 6])
          equation.enable_concatentation!
          assert equation.solvable?
        end
        it "is true for newly solvable example 2" do
          equation = Day7::CalibrationEquation.new(7290, [6, 8, 6, 15])
          equation.enable_concatentation!
          assert equation.solvable?
        end
        it "is false for unsolvable example 3" do
          equation = Day7::CalibrationEquation.new(161011, [16, 10, 13])
          equation.enable_concatentation!
          refute equation.solvable?
        end
      end
    end
  end

  describe "part2" do
    it "overall scenario" do
      expected = 11387
      actual = Day7.part2(input)
      _(actual).must_equal(expected)
    end
  end
end
