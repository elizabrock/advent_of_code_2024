require_relative 'spec_helper'

# http://adventofcode.com/2024/day/3

describe Day3 do
  let(:input) {
    <<~STRING
      xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    STRING
  }

  describe "part1" do
    it "overall scenario" do
      expected = 161
      actual = Day3.part1(input)
      _(actual).must_equal(expected)
    end
  end

  describe "part2" do
    it "overall scenario" do
      expected = 48
      actual = Day3.part2(input)
      _(actual).must_equal(expected)
    end
  end
end
