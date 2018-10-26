module BetterSet
  module Values
    RSpec.describe Partition do
      describe ".value" do
        it "returns a partition of the set based on the pased in block" do
          set = Set.new([1,2,3,4,5,6,7,8,9,10])
          greater_than_five = set.select { |n| n > 5 }
          less_than_six = set.select { |n| n < 6 }

          expect(set.partition { |n| n > 5 }).to eq(Set.new([
            greater_than_five,
            less_than_six,
          ]))
        end
      end
    end
  end
end
