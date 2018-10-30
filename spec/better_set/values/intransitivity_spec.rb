module BetterSet
  module Values
    RSpec.describe Intransitivity do
      describe ".value" do
        let(:ordered_pair1) { OrderedPair.new(1, 2) }
        let(:ordered_pair2) { OrderedPair.new(2, 3) }
        let(:ordered_pair3) { OrderedPair.new(4, 5) }
        let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }
        let(:value) { Intransitivity.value(ordered_pairs) }

        context "there is no <x,y> and <y,z> s.t <x,z> is in R" do
          it "returns true" do
            expect(value).to be(true)
          end
        end

        context "there an <x,y> and <y,x> in R s.t. <x,z> is in R" do
          let(:ordered_pair4) { OrderedPair.new(1, 3) }
          let(:new_ordered_pairs) { ordered_pairs.union(Set.new([ordered_pair4])) }
          let(:value) { Intransitivity.value(new_ordered_pairs) }

          it "returns false" do
            expect(value).to be(false)
          end
        end
      end
    end
  end
end
