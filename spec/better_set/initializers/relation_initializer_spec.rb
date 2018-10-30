module BetterSet
  module Initializers
    RSpec.describe RelationInitializer do
      describe ".value" do
        context "argument is not a set of ordered pairs" do
          it "raises an argument error" do
            expect{ RelationInitializer.value(1) }.to raise_error(
              ArgumentError,
              "Argument must be a set of ordered pairs"
            )
          end
        end

        it "returns an array of the set of ordered pairs" do
          ordered_pair = OrderedPair.new(1,2)
          ordered_pairs = Set.new(ordered_pair)

          expect(RelationInitializer.value(ordered_pairs)).to eq(Set.new(
            ordered_pair
          ))
        end
      end
    end
  end
end
