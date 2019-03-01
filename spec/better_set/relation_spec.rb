module BetterSet
  RSpec.describe Relation do
    describe "initialize" do
      let(:ordered_pair) { OrderedPair.new(1,2) }
      let(:ordered_pairs) { Set.new(ordered_pair) }
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
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2) }
      let(:relation) { Relation.new(ordered_pairs) }

      it "returns a set of the first element of each ordered pair" do
        expect(relation.domain).to eq(Set.new(1,3))
      end
    end

    describe "#range" do
      let(:ordered_pair1) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(3,4) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2) }
      let(:relation) { Relation.new(ordered_pairs) }

      it "returns a set of the second element of each ordered pair" do
        expect(relation.range).to eq(Set.new(2,4))
      end
    end

    describe "#reflexive?" do
      let(:ordered_pair1) { OrderedPair.new(1,1) }
      let(:ordered_pair2) { OrderedPair.new(2,2) }
      let(:ordered_pair3) { OrderedPair.new(2,1) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }
      subject(:relation) { Relation.new(ordered_pairs) }

      context "for every x, <x,x> is in R" do
        it "returns true" do
          expect(relation.reflexive?).to be(true)
        end
      end

      context "there is an element x s.t. <x,x> is not in R" do
        let(:ordered_pair4) { OrderedPair.new(3,1) }
        let(:new_ordered_pairs) { ordered_pairs.union(Set.new(ordered_pair4)) }
        subject(:relation) { Relation.new(new_ordered_pairs) }

        it "returns false" do
          expect(relation.reflexive?).to be(false)
        end
      end
    end

    describe "#irreflexive?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2) }
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
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }
      subject(:relation) { Relation.new(ordered_pairs) }

      context "for every x, <x,x> is in R" do
        it "returns false" do
          expect(relation.nonreflexive?).to be(false)
        end
      end

      context "there is an element x s.t. <x,x> is not in R" do
        let(:ordered_pair4) { OrderedPair.new(3,1) }
        let(:new_ordered_pairs) { ordered_pairs.union(Set.new(ordered_pair4)) }
        subject(:relation) { Relation.new(new_ordered_pairs) }

        it "returns true" do
          expect(relation.nonreflexive?).to be(true)
        end
      end
    end

    describe "#symmetric?" do
      let(:ordered_pair1) { OrderedPair.new(1,1) }
      let(:ordered_pair2) { OrderedPair.new(2,2) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "for each <x,y> in R, <y,x> is also in R" do
        it "returns true" do
          expect(relation.symmetric?).to be(true)
        end
      end

      context "there is an <x,y> in R s.t <y,x> is not in R" do
        let(:new_ordered_pair) { OrderedPair.new(3,4) }
        let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, new_ordered_pair) }

        it "returns false" do
          expect(relation.symmetric?).to be(false)
        end
      end
    end

    describe "#antisymmetric?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "there is no <x,y> in R s.t <y,x> is in R" do
        it "returns true" do
          expect(relation.antisymmetric?).to be(true)
        end
      end

      context "for all <x,y> in R s.t. <y,x> is in R" do
        let(:ordered_pair3) { OrderedPair.new(4, 4) }
        let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }

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
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "there are no x,y s.t. <x,y> and <y,x> are in R" do
        it "returns true" do
          expect(relation.asymmetric?).to be(true)
        end
      end

      context "there is at least one x,y s.t. <x,y> and <y,x> are in R" do
        let(:ordered_pair3) { OrderedPair.new(3,2) }
        let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }

        it "returns false" do
          expect(relation.asymmetric?).to be(false)
        end
      end

      context "there is a reflexive pair in R" do
        let(:ordered_pair3) { OrderedPair.new(3,3) }
        let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }

        it "returns false" do
          expect(relation.symmetric?).to be(false)
        end
      end
    end

    describe "transitive?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pair3) { OrderedPair.new(1, 3) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }
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

    describe "#nontransitive?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pair3) { OrderedPair.new(1, 3) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "every pair <x,y> and <y,z>, <x,z> is in R" do
        it "returns false" do
          expect(relation.nontransitive?).to be(false)
        end
      end

      context "there is a z s.t. <y,z> is in R and <x,z> is not in R" do
        let(:ordered_pair4) { OrderedPair.new(4, 2) }
        let(:ordered_pairs) do
          Set.new(ordered_pair1, ordered_pair2, ordered_pair3, ordered_pair4)
        end


        it "returns true" do
          expect(relation.nontransitive?).to be(true)
        end
      end
    end

    describe "#intransitive?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pair3) { OrderedPair.new(4, 5) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "there is no <x,y> and <y,z> s.t <x,z> is in R" do
        it "returns true" do
          expect(relation.intransitive?).to be(true)
        end
      end

      context "there an <x,y> and <y,x> in R s.t. <x,z> is in R" do
        let(:ordered_pair4) { OrderedPair.new(1, 3) }
        let(:ordered_pair5) { OrderedPair.new(5,6) }
        let(:new_ordered_pairs) do
          ordered_pairs.union(Set.new(ordered_pair4, ordered_pair5))
        end
        let(:relation) { Relation.new(new_ordered_pairs) }

        it "returns false" do
          expect(relation.intransitive?).to be(false)
        end
      end
    end

    describe "#connected?" do
      let(:ordered_pair1) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(2,3) }
      let(:ordered_pair3) { OrderedPair.new(3,1) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2, ordered_pair3) }
      subject(:relation) { Relation.new(ordered_pairs) }

      context "for all x,y in domain(R), either <x,y> or <y,x>" do
        it "returns true" do
          expect(relation.connected?).to be(true)
        end
      end

      context "there is an x,y in domain(R) s.t., neither <x,y> or <y,x>" do
        let(:ordered_pair3) { OrderedPair.new(4,7) }
        let(:new_ordered_pairs) { ordered_pairs.union(Set.new(ordered_pair3)) }
        subject(:relation) { Relation.new(new_ordered_pairs) }

        it "returns false" do
          expect(relation.connected?).to be(false)
        end
      end
    end

    describe "#union" do
      let(:ordered_pair) { OrderedPair.new(1,1) }
      let(:relation) { Relation.new(Set.new(ordered_pair)) }

      context "other is a relation" do
        let(:other_pair) { OrderedPair.new(1,2) }
        let(:other) { Relation.new(Set.new(other_pair)) }

        it "returns the union of the relations" do
          expect(relation.union(other)).to eq(
            Relation.new(
              Set.new(ordered_pair,other_pair)
            )
          )
        end
      end

      context "other is not a relation but a set" do
        let(:other) { Set.new(5) }

        it "returns a set with all elements" do
          expect(relation.union(other)).to eq(
            Set.new(ordered_pair,5)
          )
        end
      end

      context "other is neither a set nor relation" do
        let(:other) { 5 }

        it "raises an error" do
          expect { relation.union(other) }.to raise_error(
            ArgumentError,
            "Argument must be a BetterSet"
          )
        end
      end
    end

    describe "#intersection" do
      let(:ordered_pair) { OrderedPair.new(1,1) }
      let(:ordered_pair2) { OrderedPair.new(1,2) }
      let(:relation) { Relation.new(Set.new(ordered_pair, ordered_pair2)) }

      context "other is a relation" do
        let(:other_ordered_pair) { ordered_pair }
        let(:other_ordered_pair2) { OrderedPair.new(1,3) }
        let(:other) { Relation.new(Set.new(other_ordered_pair, other_ordered_pair2)) }

        it "returns a relation with the elements in common" do
          expect(relation.intersection(other)).to eq(
            Relation.new(Set.new(other_ordered_pair))
          )
        end
      end

      context "other is not a relation but a set" do
        let(:other) { Set.new(ordered_pair, 1) }

        it "returns a set with the elements in common" do
          expect(relation.intersection(other)).to eq(
            Set.new(ordered_pair)
          )
        end
      end

      context "other is neither a set nor relation" do
        let(:other) { 5 }

        it "raises an error" do
          expect { relation.intersection(other) }.to raise_error(
            ArgumentError,
            "Argument must be a BetterSet",
          )
        end
      end
    end

    describe "#difference" do
      let(:ordered_pair) { OrderedPair.new(1,1) }
      let(:ordered_pair2) { OrderedPair.new(1,2) }
      let(:relation) { Relation.new(Set.new(ordered_pair, ordered_pair2)) }

      context "other is a relation" do
        let(:other) { Relation.new(Set.new(ordered_pair2)) }

        it "returns a relation without the elements in other" do
          expect(relation.difference(other)).to eq(
            Relation.new(
              Set.new(ordered_pair)
            )
          )
        end
      end

      context "other is not a relation but a set" do
        let(:other) { Set.new(OrderedPair.new(1,2), 5) }

        it "returns a set without the elements in other" do
          expect(relation.difference(other)).to eq(
            Set.new(ordered_pair)
          )
        end
      end

      context "other is neither a set nor relation" do
        let(:other) { 5 }

        it "raises an error" do
          expect { relation.difference(other) }.to raise_error(
            ArgumentError,
            "Argument must be a BetterSet",
          )
        end
      end
    end

    describe "#add" do
      let(:ordered_pair) { OrderedPair.new(1,2) }
      let(:relation) { Relation.new(Set.new(ordered_pair)) }

      context "element is ordered pair" do
        let(:other) { OrderedPair.new(3,3) }

        it "returns relation with new ordered pair" do
          expect(relation.add(other)).to eq(
            Relation.new(
              Set.new(ordered_pair, other)
            )
          )
        end
      end

      context "element is not an ordered pair" do
        let(:other) { 1 }

        it "returns a set with the new element" do
          expect(relation.add(other)).to eq(
            Set.new(ordered_pair, other)
          )
        end
      end
    end

    describe "#remove" do
      let(:ordered_pair) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(3,3) }
      let(:relation) { Relation.new(Set.new(ordered_pair, ordered_pair2)) }

      context "element is ordered pair" do
        let(:other) { OrderedPair.new(3,3) }

        it "returns relation with new ordered pair" do
          expect(relation.remove(other)).to eq(
            Relation.new(
              Set.new(ordered_pair)
            )
          )
        end
      end

      context "element is not an ordered pair" do
        let(:other) { 1 }

        it "returns a the empty set" do
          expect(relation.remove(other)).to eq(relation)
        end
      end
    end

    describe "#cartesian_product" do
      let(:ordered_pair) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(3,3) }
      let(:ordered_pairs) { Set.new(ordered_pair, ordered_pair2) }
      let(:relation) { Relation.new(ordered_pairs) }

      context "other is not a relation or a set" do
        let(:other) { "hey"}

        it "raises an argument error" do
          expect { relation.cartesian_product(other) }.to raise_error(
            ArgumentError,
            "Argument must be a BetterSet",
          )
        end
      end

      context "other is a relation" do
        let(:other_pair) { OrderedPair.new(1,2) }
        let(:other_pairs) { Set.new(other_pair) }
        let(:other) { Relation.new(other_pairs) }

        it "returns the cartesian product of two sets as a relation" do
          expect(relation.cartesian_product(other)).to eq(
            Relation.new(
              Set.new(
                OrderedPair.new(ordered_pair, other_pair),
                OrderedPair.new(ordered_pair2, other_pair)
              )
            )
          )
        end
      end

      context "other is a set" do
        let(:other) { Set.new(1,2) }

        it "returns the cartesian product of two sets as a relation" do
          expect(relation.cartesian_product(other)).to eq(
            Relation.new(
              Set.new(
                OrderedPair.new(ordered_pair, 1),
                OrderedPair.new(ordered_pair, 2),
                OrderedPair.new(ordered_pair2, 1),
                OrderedPair.new(ordered_pair2, 2)
              )
            )
          )
        end
      end
    end

    describe "equivalence_relation?" do
      let(:ordered_pair1) { OrderedPair.new(1, 2) }
      let(:ordered_pair2) { OrderedPair.new(2, 3) }
      let(:ordered_pair3) { OrderedPair.new(1, 3) }
      let(:ordered_pair4) { OrderedPair.new(2, 1) }
      let(:ordered_pair5) { OrderedPair.new(3, 1) }
      let(:ordered_pair6) { OrderedPair.new(3, 2) }
      let(:ordered_pair7) { OrderedPair.new(1, 1) }
      let(:ordered_pair8) { OrderedPair.new(2, 2) }
      let(:ordered_pair9) { OrderedPair.new(3, 3) }
      let(:ordered_pairs) do
        Set.new(
          ordered_pair1,
          ordered_pair2,
          ordered_pair3,
          ordered_pair4,
          ordered_pair5,
          ordered_pair6,
          ordered_pair7,
          ordered_pair8,
          ordered_pair9
        )
      end
      subject(:relation) { Relation.new(ordered_pairs) }

      context "relation is symmetric" do
        context "relation is transitive" do
          context "relation is reflexive" do
            it "returns true" do
              expect(relation.symmetric?).to be(true)
              expect(relation.transitive?).to be(true)
              expect(relation.reflexive?).to be(true)
              expect(relation.equivalence_relation?).to be(true)
            end
          end
        end

        context "relation is not transitive" do
          context "relation is reflexive" do
            let(:ordered_pairs) do
              Set.new(
                ordered_pair2,
                ordered_pair3,
                ordered_pair5,
                ordered_pair6,
                ordered_pair7,
                ordered_pair8,
                ordered_pair9
              )
            end

            it "returns false" do
              expect(relation.symmetric?).to be(true)
              expect(relation.transitive?).to be(false)
              expect(relation.reflexive?).to be(true)
              expect(relation.equivalence_relation?).to be(false)
            end
          end

          context "relation is not reflexive" do
            let(:ordered_pairs) do
              Set.new(
                ordered_pair2,
                ordered_pair3,
                ordered_pair5,
                ordered_pair6,
              )
            end

            it "returns false" do
              expect(relation.symmetric?).to be(true)
              expect(relation.transitive?).to be(false)
              expect(relation.reflexive?).to be(false)
              expect(relation.equivalence_relation?).to be(false)
            end
          end
        end
      end

      context "relation is not symmetric" do
        context "relation is transitive" do
          context "relation is reflexive" do
            let(:ordered_pairs) do
              Set.new(
                ordered_pair1,
                ordered_pair7
              )
            end

            it "returns false" do
              expect(relation.symmetric?).to be(false)
              expect(relation.transitive?).to be(true)
              expect(relation.reflexive?).to be(true)
              expect(relation.equivalence_relation?).to be(false)
            end
          end

          context "relation is not reflexive" do
            let(:ordered_pairs) do
              Set.new(
                ordered_pair1,
              )
            end

            it "returns false" do
              expect(relation.symmetric?).to be(false)
              expect(relation.transitive?).to be(true)
              expect(relation.reflexive?).to be(false)
              expect(relation.equivalence_relation?).to be(false)
            end
          end
        end

        context "relation is not transitive" do
          context "relation is reflexive" do
            let(:ordered_pairs) do
              Set.new(
                ordered_pair7,
                ordered_pair3,
                ordered_pair6,
                ordered_pair9,
              )
            end

            it "returns false" do
              expect(relation.symmetric?).to be(false)
              expect(relation.transitive?).to be(false)
              expect(relation.reflexive?).to be(true)
              expect(relation.equivalence_relation?).to be(false)
            end
          end

          context "relation is not reflexive" do
            let(:ordered_pairs) do
              Set.new(
                ordered_pair7,
                ordered_pair3,
                ordered_pair6,
              )
            end

            it "returns false" do
              expect(relation.symmetric?).to be(false)
              expect(relation.transitive?).to be(false)
              expect(relation.reflexive?).to be(false)
              expect(relation.equivalence_relation?).to be(false)
            end
          end
        end
      end
    end

    describe "semi_connex?" do
      let(:elements) { [1,2,3,4] }
      let(:domain) { Set.new(elements) }

      subject(:relation) { domain.cartesian_product(domain) }

      context "every element is semi connex in self" do
        it "returns true" do
          expect(relation.semi_connex?).to eq(true)
        end
      end

      context "at least on element is not semi connex in self" do
        subject(:relation) { domain.cartesian_product(Set.new(1, 2, 3)) }

        it "returns false" do
          expect(relation.semi_connex?).to eq(false)
        end
      end
    end
  end
end
