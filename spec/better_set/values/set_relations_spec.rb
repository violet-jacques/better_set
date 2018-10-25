module BetterSet
  module Values
    RSpec.describe SetRelations do
      let(:set) { Set.new }
      subject(:set_relations) { SetRelations.new(set) }

      describe "#==" do
        context "other is not a set" do
          it "returns false" do
            other = "hey"

            expect(set_relations == other).to be(false)
          end
        end

        context "self is a subset of other" do
          context "self is a superset of other" do
            it "returns true" do
              expect(set_relations == set).to be(true)
            end

            context "self is not a superset of other" do
              it "returns false" do
                expect(set_relations == Set.new(["justine"])).to be(false)
              end
            end
          end
        end

        context "self is a superset of other" do
          context "self is not a super set of other" do
            it "returns false" do
              expect(set_relations == Set.new(["justine"])).to be(false)
            end
          end
        end

        context "self and other are disjoint" do
          it "returns false" do
            expect(set_relations == Set.new(["justine"])).to be(false)
          end
        end
      end

      describe "#subset?" do
        context "other is not a set" do
          it "returns false" do
            expect(set_relations.subset?("hey")).to be(false)
          end
        end

        context "self is the empty set" do
          it "returns true" do
            expect(set_relations.subset?(Set.new(["hey"]))).to be(true)
          end
        end

        context "all of the elements in self are in other" do
          let(:set) { Set.new(["hey"]) }

          it "returns true" do
            other = Set.new(["hey", "dawg"])

            expect(set_relations.subset?(other)).to be(true)
          end
        end

        context "all of the elements in other are in self" do
          let(:set) { Set.new(["hey", "dawg"]) }

          it "returns false" do
            other = Set.new(["hey"])

            expect(set_relations.subset?(other)).to be(false)
          end
        end

        context "self is the same as other" do
          let(:set) { Set.new(["hey"]) }

          it "returns true" do
            other = Set.new(["hey"])

            expect(set_relations.subset?(other)).to be(true)
          end
        end

        context "at least one of the elements in self is not in other" do
          let(:set) { Set.new(["hey"]) }

          it "returns false" do
            other = Set.new(["dawg"])

            expect(set_relations.subset?(other)).to be(false)
          end
        end
      end

      describe "#proper_subset?" do
        context "other is not a set" do
          it "returns false" do
            expect(set_relations.proper_subset?("other")).to be(false)
          end
        end

        context "self is the empty set" do
          context "other is not the empty set" do
            it "returns true" do
              expect(set_relations.proper_subset?(Set.new(["hey"]))).to be(true)
            end
          end

          context "other is the empty set" do
            it "returns false" do
              expect(set_relations.proper_subset?(set)).to be(false)
            end
          end
        end

        context "all of the elements in self are in other" do
          let(:set) { Set.new(["hey"]) }

          it "returns true" do
            other = Set.new(["hey", "dawg"])

            expect(set_relations.proper_subset?(other)).to be(true)
          end
        end

        context "all of the elements in other are in self" do
          let(:set) { Set.new(["hey", "dawg"]) }

          it "returns false" do
            other = Set.new(["hey"])

            expect(set_relations.proper_subset?(other)).to be(false)
          end
        end

        context "at least one of the elements in self is not in other" do
          let(:set) { Set.new(["yo"]) }

          it "returns false" do
            other = Set.new(["dawg"])

            expect(set_relations.proper_subset?(other)).to be(false)
          end
        end

        context "self is a subset of other and a superset" do
          let(:set) { Set.new(["yo"]) }

          it "returns false" do
            other = Set.new(["yo"])

            expect(set_relations.proper_subset?(other)).to be(false)
          end
        end
      end

      describe "#superset?" do
        context "other is not a set" do
          it "returns false" do
            expect(set_relations.superset?("other")).to be(false)
          end
        end

        context "self is the empty set" do
          it "returns false" do
            other = Set.new(["hey"])

            expect(set_relations.superset?(other)).to be(false)
          end
        end

        context "all of the elements in self are in other" do
          let(:set) { Set.new(["hey"]) }

          it "returns false" do
            other = Set.new(["hey", "dawg"])

            expect(set_relations.superset?(other)).to be(false)
          end
        end

        context "all of the elements in other are in self" do
          let(:set) { Set.new(["hey", "dawg"]) }

          it "returns false" do
            other = Set.new(["hey"])

            expect(set_relations.superset?(other)).to be(true)
          end
        end

        context "self is the same as other" do
          let(:set) { Set.new(["hey"]) }

          it "returns true" do
            other = Set.new(["hey"])

            expect(set_relations.superset?(other)).to be(true)
          end
        end

        context "at least one of the elements in other is not in self" do
          let(:set) { Set.new(["yo", "hey"]) }

          it "returns false" do
            other = Set.new(["dawg", "yo"])

            expect(set_relations.superset?(other)).to be(false)
          end
        end
      end

      describe "#proper_superset?" do
        context "other is not a set" do
          it "returns false" do
            expect(set_relations.proper_superset?("other")).to be(false)
          end
        end

        context "self is the empty set" do
          context "other is not the empty set" do
            it "returns false" do
              other = Set.new(["hey"])

              expect(set_relations.proper_superset?(other)).to be(false)
            end
          end

          context "other is the empty set" do
            it "returns false" do
              other = Set.new

              expect(set_relations.proper_superset?(other)).to be(false)
            end
          end
        end

        context "all of the elements in other are in self" do
          let(:set) { Set.new(["hey", "dawg"]) }

          it "returns true" do
            other = Set.new(["hey"])

            expect(set_relations.proper_superset?(other)).to be(true)
          end
        end

        context "at least one of the elements in other is not in self" do
          let(:set) { Set.new(["yo", "hey", "son"]) }

          it "returns false" do
            other = Set.new(["dawg", "yo"])

            expect(set_relations.proper_superset?(other)).to be(false)
          end
        end

        context "self is a superset of other and a subset of other" do
          let(:set) { Set.new(["yo"]) }

          it "returns false" do
            expect(set_relations.proper_superset?(set)).to be(false)
          end
        end
      end

      describe "#union" do
        context "other is not a set" do
          it "raises an argument error" do
            other = "hey"

            expect { set_relations.union(other) }.to raise_error(
              ArgumentError,
              "Argument must be a BetterSet",
            )
          end
        end

        let(:array) { [1,2,3] }
        let(:set) { Set.new(array) }

        it "returns a set with all the elements from both sets" do
          array2 = ["hey", 3, Set.new]
          set2 = Set.new(array2)

          expect(set_relations.union(set2)).to eq(
            Set.new([1, 2, 3, "hey", Set.new])
          )
        end
      end

      describe "#intersection" do
        context "other is not a set" do
          it "raises an argument error" do
            other = "hey"

            expect { set_relations.intersection(other) }.to raise_error(
              ArgumentError,
              "Argument must be a BetterSet",
            )
          end
        end

        let(:array) { [1, Set.new, 3] }
        let(:set) { Set.new(array) }

        it "returns a set with only the elements in both sets" do
          array2 = ["hey", 3, Set.new]
          set2 = Set.new(array2)

          expect(set_relations.intersection(set2)).to eq(
            Set.new([3, Set.new])
          )
        end
      end

      describe "#difference" do
        context "other is not a set" do
          it "raises an argument error" do
            other = "hey"

            expect { set_relations.difference(other) }.to raise_error(
              ArgumentError,
              "Argument must be a BetterSet",
            )
          end
        end

        let(:array) { [1, Set.new, 3] }
        let(:set) { Set.new(array) }

        it "returns a set with all the elements in self but not in other" do
          array2 = ["hey", 3, Set.new]
          set2 = Set.new(array2)

          expect(set_relations.difference(set2)).to eq(
            Set.new([1])
          )
        end
      end

      describe "#-" do
        context "other is not a set" do
          it "raises an argument error" do
            other = "hey"

            expect { set_relations - other }.to raise_error(
              ArgumentError,
              "Argument must be a BetterSet",
            )
          end
        end

        let(:array) { [1, Set.new, 3] }
        let(:set) { Set.new(array) }

        it "returns a set with all the elements in self but not in other" do
          array2 = ["hey", 3, Set.new]
          set2 = Set.new(array2)

          expect(set_relations - set2).to eq(
            Set.new([1])
          )
        end
      end
    end
  end
end
