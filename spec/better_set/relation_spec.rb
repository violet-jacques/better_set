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
      let(:ordered_pair1) { OrderedPair.new(1,1) }
      let(:ordered_pair2) { OrderedPair.new(2,2) }
      let(:ordered_pair3) { OrderedPair.new(2,1) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }
      subject(:relation) { Relation.new(ordered_pairs) }

      context "for every x, <x,x> is in R" do
        it "returns true" do
          expect(relation.reflexive?).to be(true)
        end
      end

      context "there is an element x s.t. <x,x> is not in R" do
        let(:ordered_pair4) { OrderedPair.new(3,1) }
        let(:new_ordered_pairs) { ordered_pairs.union(Set.new([ordered_pair4])) }
        subject(:relation) { Relation.new(new_ordered_pairs) }

        it "returns false" do
          expect(relation.reflexive?).to be(false)
        end
      end
    end

    describe "#irreflexive?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2]) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "there are no x s.t. <x,x> in R" do
        it "returns true" do
          expect(relation.irreflexive?).to be(true)
        end
      end

      context "there is an x s.t. <x,x> in R" do
        let(:ordered_pair2) { OrderedPair.new(2, 2) }

        it "returns true" do
          expect(relation.irreflexive?).to be(false)
        end
      end
    end

    describe "#nonreflexive?" do
      let(:ordered_pair1) { OrderedPair.new(1,1) }
      let(:ordered_pair2) { OrderedPair.new(2,2) }
      let(:ordered_pair3) { OrderedPair.new(2,1) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }
      subject(:relation) { Relation.new(ordered_pairs) }

      context "for every x, <x,x> is in R" do
        it "returns false" do
          expect(relation.nonreflexive?).to be(false)
        end
      end

      context "there is an element x s.t. <x,x> is not in R" do
        let(:ordered_pair4) { OrderedPair.new(3,1) }
        let(:new_ordered_pairs) { ordered_pairs.union(Set.new([ordered_pair4])) }
        subject(:relation) { Relation.new(new_ordered_pairs) }

        it "returns true" do
          expect(relation.nonreflexive?).to be(true)
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

    describe "#antisymmetric?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2]) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "there is no <x,y> in R s.t <y,x> is in R" do
        it "returns true" do
          expect(relation.antisymmetric?).to be(true)
        end
      end

      context "for all <x,y> in R s.t. <y,x> is in R" do
        let(:ordered_pair3) { OrderedPair.new(4, 4) }
        let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }

        context "if x == y" do
          it "returns true" do
            expect(relation.antisymmetric?).to be(true)
          end
        end

        context "if x != y" do
          let(:ordered_pair3) { OrderedPair.new(2, 1) }

          it "returns false" do
            expect(relation.antisymmetric?).to be(false)
          end
        end
      end
    end

    describe "#asymmetric?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2]) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "there are no x,y s.t. <x,y> and <y,x> are in R" do
        it "returns true" do
          expect(relation.asymmetric?).to be(true)
        end
      end

      context "there is at least one x,y s.t. <x,y> and <y,x> are in R" do
        let(:ordered_pair3) { OrderedPair.new(3,2) }
        let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }

        it "returns false" do
          expect(relation.asymmetric?).to be(false)
        end
      end

      context "there is a reflexive pair in R" do
        let(:ordered_pair3) { OrderedPair.new(3,3) }
        let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }

        it "returns false" do
          expect(relation.symmetric?).to be(false)
        end
      end
    end

    describe "transitive?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pair3) { OrderedPair.new(1, 3) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "every pair <x,y> and <y,z>, <x,z> is in R" do
        it "returns true" do
          expect(relation.transitive?).to be(true)
        end
      end

      context "there is a z s.t. <y,z> is in R and <x,z> is not in R" do
        let(:ordered_pair3) { OrderedPair.new(4, 3) }

        it "returns false" do
          expect(relation.transitive?).to be(false)
        end
      end
    end

    describe "#connected?" do
      let(:ordered_pair1) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(2,3) }
      let(:ordered_pair3) { OrderedPair.new(3,1) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2, ordered_pair3]) }
      subject(:relation) { Relation.new(ordered_pairs) }

      context "for all x,y in domain(R), either <x,y> or <y,x>" do
        it "returns true" do
          expect(relation.connected?).to be(true)
        end
      end

      context "there is an x,y in domain(R) s.t., neither <x,y> or <y,x>" do
        let(:ordered_pair3) { OrderedPair.new(4,7) }
        let(:new_ordered_pairs) { ordered_pairs.union(Set.new([ordered_pair3])) }
        subject(:relation) { Relation.new(new_ordered_pairs) }

        it "returns false" do
          expect(relation.connected?).to be(false)
        end
      end
    end
  end
end
