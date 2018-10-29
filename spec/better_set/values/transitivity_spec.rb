module BetterSet
  module Values
    RSpec.describe Transitivity do
      describe ".value" do
        let(:ordered_pair1) { OrderedPair.new(1, 2) }
        let(:ordered_pair2) { OrderedPair.new(2, 3) }
        let(:ordered_pair3) { OrderedPair.new(1, 3) }
        let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }
        let(:value) { Transitivity.value(ordered_pairs) }

        context "every pair <x,y> and <y,z>, <x,z> is in R" do
          it "returns true" do
            expect(value).to be(true)
          end
        end

        context "there is a z s.t. <y,z> is in R and <x,z> is not in R" do
          let(:ordered_pair3) { OrderedPair.new(4, 3) }

          it "returns false" do
            expect(value).to be(false)
          end
        end
      end
    end
  end
end
