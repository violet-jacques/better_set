module BetterSet
  RSpec.describe Relation do
    describe "initialize" do
      let(:ordered_pair) { OrderedPair.new(1,2) }
      let(:ordered_pairs) { Set.new([ordered_pair]) }
      subject(:relation) { Relation.new(ordered_pairs) }

      context "invalid argument" do
        it "raises an error" do
          expect{ Relation.new(1) }.to raise_error(
            ArgumentError,
            "Argument must be a set of ordered pairs"
          )
        end
      end

      it "properly initializes the relation" do
        expect(relation.instance_variable_get(:@hash).keys).to eq([
          ordered_pair
        ])
      end
    end

    describe "#domain" do
      let(:ordered_pair1) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(3,4) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2]) }
      let(:relation) { Relation.new(ordered_pairs) }

      it "returns a set of the first element of each ordered pair" do
        expect(relation.domain).to eq(Set.new([1,3]))
      end
    end

    describe "#range" do
      let(:ordered_pair1) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(3,4) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2]) }
      let(:relation) { Relation.new(ordered_pairs) }

      it "returns a set of the second element of each ordered pair" do
        expect(relation.range).to eq(Set.new([2,4]))
      end
    end
  end
end
