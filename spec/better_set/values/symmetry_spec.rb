module BetterSet
  module Values
    RSpec.describe Symmetry do
      describe ".value" do
      let(:ordered_pair1) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(2,1) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2) }
      subject(:symmetry_value) { Symmetry.value(ordered_pairs) }

        context "ordered_pairs is empty" do
          let(:ordered_pairs) { Set.new }

          it "returns true" do
            expect(symmetry_value).to be(true)
          end
        end

        context "for every <x,y> in R, <y,x> is in R" do
          it "returns true" do
            expect(symmetry_value).to be(true)
          end
        end

        context "there is an <x,y> in R s.t. <y,x> is not in R" do
          let(:ordered_pair3) { OrderedPair.new(3,1) }
          let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }

          it "returns false" do
            expect(symmetry_value).to be(false)
          end
        end
      end
    end
  end
end
