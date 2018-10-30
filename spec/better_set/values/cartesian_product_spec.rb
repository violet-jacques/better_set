module BetterSet
  module Values
    RSpec.describe CartesianProduct do
      describe ".value" do
        it "returns the cartesian product of two sets as a relation" do
          domain = Set.new(1,2)
          range = Set.new(3,4)
          ordered_pair = OrderedPair.new(1,3)
          ordered_pair2 = OrderedPair.new(1,4)
          ordered_pair3 = OrderedPair.new(2,3)
          ordered_pair4 = OrderedPair.new(2,4)
          ordered_pairs = Set.new(
            ordered_pair,
            ordered_pair2,
            ordered_pair3,
            ordered_pair4
          )
          relation = Relation.new(ordered_pairs)

          expect(CartesianProduct.value(domain, range)).to eq(relation)
        end
      end
    end
  end
end
