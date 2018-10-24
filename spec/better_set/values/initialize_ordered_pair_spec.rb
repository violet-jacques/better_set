module BetterSet
  module Values
    RSpec.describe InitializeOrderedPair do
      describe ".value" do
        it "returns an array containing a set of the first coordinate and a set of both" do
          first = 1
          second = 2

          expect(InitializeOrderedPair.value(first,second)).to eq([
            Set.new([first]),
            Set.new([first, second])
          ])
        end
      end
    end
  end
end
