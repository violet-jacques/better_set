module BetterSet
  module Values
    RSpec.describe InitializeRelation do
      describe ".value" do
        context "argument is not a set of ordered pairs" do
          it "raises an argument error" do
            expect{ InitializeRelation.value(1) }.to raise_error(
              ArgumentError,
              "Argument must be a set of ordered pairs"
            )
          end
        end

        it "returns an array of the set of ordered pairs" do
          ordered_pair = OrderedPair.new(1,2)
          ordered_pairs = Set.new([ordered_pair])

          expect(InitializeRelation.value(ordered_pairs)).to eq([
            ordered_pair
          ])
        end
      end
    end
  end
end
