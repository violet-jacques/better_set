module BetterSet
  module Initializers
    RSpec.describe OrderedPairInitializer do
      describe ".value" do
        it "returns an array containing a set of the first coordinate and a set of both" do
          first = 1
          second = 2

          expect(OrderedPairInitializer.value(first,second)).to eq([
            Set.new([first]),
            Set.new([first, second])
          ])
        end
      end
    end
  end
end
