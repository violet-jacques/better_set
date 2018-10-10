module BetterSet
  RSpec.describe MikeSet do
    describe "initialize" do
      context "no arguments" do
        it "initializes an empty set" do
          set = MikeSet.new

          expect(set.instance_variable_get(:@hash)).to eq(Hash.new(false))
        end
      end

      context "argument is not an array" do
        it "raises an error" do
          expect { MikeSet.new("hey") }.to raise_error(
            ArgumentError,
            "Argument must be Array class",
          )
        end
      end

      context "array of stuff" do
        it "creates and stores hash out of the array" do
          set = MikeSet.new(["justine"])

          expect(set.instance_variable_get(:@hash)).to eq(
            "justine" => true,
          )
        end
      end

      context "duplicates" do
        it "does not store duplicates" do
          set = MikeSet.new(["justine", "justine", 1, 1])

          expect(set.instance_variable_get(:@hash)).to eq(
            "justine" => true,
            1 => true,
          )
        end
      end
    end

    describe "#==" do
      context "self is a subset of other" do
        context "self is a superset of other" do
          it "returns true" do
            set = MikeSet.new
            other = MikeSet.new

            expect(set == other).to be(true)
          end

          context "self is not a superset of other" do
            it "returns false" do
              set = MikeSet.new
              other = MikeSet.new(["justine"])

              expect(set == other).to be(false)
            end
          end
        end
      end

      context "self is a superset of other" do
        context "self is not a super set of other" do
          it "returns false" do
            set = MikeSet.new
            other = MikeSet.new(["justine"])

            expect(set == other).to be(false)
          end
        end
      end

      context "self and other are disjoint" do
        it "returns false" do
          set = MikeSet.new(["mike"])
          other = MikeSet.new(["justine"])

          expect(set == other).to be(false)
        end
      end
    end

    describe "#subset?" do
      context "other is not a set" do
        it "raises an argument error" do
          set = MikeSet.new
          other = "hey"

          expect { set.subset?(other) }.to raise_error(
            ArgumentError,
            "Argument must be a BetterSet",
          )
        end
      end

      context "self is the empty set" do
        it "returns true" do
          set = MikeSet.new

          other = MikeSet.new(["hey"])

          expect(set.subset?(other)).to be(true)
        end
      end

      context "all of the elements in self are in other" do
        it "returns true" do
          set = MikeSet.new(["hey"])

          other = MikeSet.new(["hey", "dawg"])

          expect(set.subset?(other)).to be(true)
        end
      end

      context "all of the elements in other are in self" do
        it "returns false" do
          other = MikeSet.new(["hey"])
          set = MikeSet.new(["hey", "dawg"])

          expect(set.subset?(other)).to be(false)
        end
      end

      context "self is the same as other" do
        it "returns true" do
          set = MikeSet.new(["hey"])

          other = MikeSet.new(["hey"])

          expect(set.subset?(other)).to be(true)
        end
      end

      context "at least one of the elements in self is not in other" do
        it "returns false" do
          set = MikeSet.new(["yo"])

          other = MikeSet.new(["dawg"])

          expect(set.subset?(other)).to be(false)
        end
      end
    end

    describe "#proper_subset?" do
      context "other is not a set" do
        it "raises an argument error" do
          set = MikeSet.new
          other = "hey"

          expect { set.proper_subset?(other) }.to raise_error(
            ArgumentError,
            "Argument must be a BetterSet",
          )
        end
      end

      context "self is the empty set" do
        context "other is not the empty set" do
          it "returns true" do
            set = MikeSet.new

            other = MikeSet.new(["hey"])

            expect(set.proper_subset?(other)).to be(true)
          end
        end

        context "other is the empty set" do
          it "returns false" do
            set = MikeSet.new

            other = MikeSet.new

            expect(set.proper_subset?(other)).to be(false)
          end
        end
      end

      context "all of the elements in self are in other" do
        it "returns true" do
          set = MikeSet.new(["hey"])

          other = MikeSet.new(["hey", "dawg"])

          expect(set.proper_subset?(other)).to be(true)
        end
      end

      context "all of the elements in other are in self" do
        it "returns false" do
          other = MikeSet.new(["hey"])
          set = MikeSet.new(["hey", "dawg"])

          expect(set.proper_subset?(other)).to be(false)
        end
      end

      context "at least one of the elements in self is not in other" do
        it "returns false" do
          set = MikeSet.new(["yo"])

          other = MikeSet.new(["dawg"])

          expect(set.proper_subset?(other)).to be(false)
        end
      end

      context "self is a subset of other and a superset" do
        it "returns false" do
          set = MikeSet.new(["yo"])

          other = MikeSet.new(["yo"])

          expect(set.proper_subset?(other)).to be(false)
        end
      end
    end

    describe "#superset?" do
      context "other is not a set" do
        it "raises an argument error" do
          set = MikeSet.new
          other = "hey"

          expect { set.superset?(other) }.to raise_error(
            ArgumentError,
            "Argument must be a BetterSet",
          )
        end
      end

      context "self is the empty set" do
        it "returns false" do
          set = MikeSet.new
          other = MikeSet.new(["hey"])

          expect(set.superset?(other)).to be(false)
        end
      end

      context "all of the elements in self are in other" do
        it "returns false" do
          set = MikeSet.new(["hey"])
          other = MikeSet.new(["hey", "dawg"])

          expect(set.superset?(other)).to be(false)
        end
      end

      context "all of the elements in other are in self" do
        it "returns false" do
          other = MikeSet.new(["hey"])
          set = MikeSet.new(["hey", "dawg"])

          expect(set.superset?(other)).to be(true)
        end
      end

      context "self is the same as other" do
        it "returns true" do
          set = MikeSet.new(["hey"])
          other = MikeSet.new(["hey"])

          expect(set.superset?(other)).to be(true)
        end
      end

      context "at least one of the elements in other is not in self" do
        it "returns false" do
          set = MikeSet.new(["yo", "hey"])
          other = MikeSet.new(["dawg", "yo"])

          expect(set.superset?(other)).to be(false)
        end
      end
    end

    describe "#proper_superset?" do
      context "other is not a set" do
        it "raises an argument error" do
          set = MikeSet.new
          other = "hey"

          expect { set.proper_superset?(other) }.to raise_error(
            ArgumentError,
            "Argument must be a BetterSet",
          )
        end
      end

      context "self is the empty set" do
        context "other is not the empty set" do
          it "returns false" do
            set = MikeSet.new
            other = MikeSet.new(["hey"])

            expect(set.proper_superset?(other)).to be(false)
          end
        end

        context "other is the empty set" do
          it "returns false" do
            set = MikeSet.new
            other = MikeSet.new

            expect(set.proper_superset?(other)).to be(false)
          end
        end
      end

      context "all of the elements in other are in self" do
        it "returns true" do
          other = MikeSet.new(["hey"])
          set = MikeSet.new(["hey", "dawg"])

          expect(set.proper_superset?(other)).to be(true)
        end
      end

      context "at least one of the elements in other is not in self" do
        it "returns false" do
          set = MikeSet.new(["yo", "hey", "son"])
          other = MikeSet.new(["dawg", "yo"])

          expect(set.proper_superset?(other)).to be(false)
        end
      end

      context "self is a superset of other and a subset of other" do
        it "returns false" do
          set = MikeSet.new(["yo"])

          other = MikeSet.new(["yo"])

          expect(set.proper_superset?(other)).to be(false)
        end
      end
    end

    describe "#inspect" do
      context "empty set" do
        it "returns the correct representation" do
          set = MikeSet.new

          expect(set.inspect).to eq("#<BetterSet: Ø>")
        end
      end

      context "non empty" do
        it "returns the correct representation" do
          set = MikeSet.new(["justine", 4, [1, "hey"], {foo: :bar}])

          expect(set.inspect).to eq('#<BetterSet: {"justine", 4, [1, "hey"], {:foo=>:bar}}>')
        end
      end
    end
  end
end
