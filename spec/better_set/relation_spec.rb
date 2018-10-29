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

    describe "#reflexive?" do
      let(:reflexive_pair1) { OrderedPair.new(1,1) }
      let(:reflexive_pair2) { OrderedPair.new(2,2) }
      let(:ordered_pairs) { Set.new([reflexive_pair1, reflexive_pair2]) }
      subject(:relation) { Relation.new(ordered_pairs) }

      context "for every x, <x,x> is in R" do
        it "returns true" do
          expect(relation.reflexive?).to be(true)
        end
      end

      context "there is an element x s.t. <x,x> is not in R" do
        let(:non_reflexive_pair) { OrderedPair.new(3,4) }
        let(:ordered_pairs) { Set.new([reflexive_pair1, reflexive_pair2, non_reflexive_pair]) }

        it "returns false" do
          expect(relation.reflexive?).to be(false)
        end
      end
    end

    describe "#symmetric?" do
      let(:ordered_pair1) { OrderedPair.new(1,1) }
      let(:ordered_pair2) { OrderedPair.new(2,2) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2]) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "for each <x,y> in R, <y,x> is also in R" do
        it "returns true" do
          expect(relation.symmetric?).to be(true)
        end
      end

      context "there is an <x,y> in R s.t <y,x> is not in R" do
        let(:new_ordered_pair) { OrderedPair.new(3,4) }
        let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, new_ordered_pair]) }

        it "returns false" do
          expect(relation.symmetric?).to be(false)
        end
      end
    end
  end
end
