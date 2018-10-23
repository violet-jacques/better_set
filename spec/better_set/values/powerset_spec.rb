module BetterSet
  module Values
    RSpec.describe Powerset do
      describe ".value" do
        it "returns the set of subsets for a given set" do
          set = Set.new
          set2 = Set.new([1,2])

          expect(Powerset.value(set)).to eq(Set.new([Set.new]))
          expect(Powerset.value(set2)).to eq(
            Set.new([
              Set.new,
              Set.new([1]),
              Set.new([2]),
              Set.new([1, 2])
            ])
          )
        end
      end
    end
  end
end
