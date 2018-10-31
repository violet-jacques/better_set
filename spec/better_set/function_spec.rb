module BetterSet
  RSpec.describe Function do
    describe "initialization" do
      let(:ordered_pair1) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(3,4) }
      let(:ordered_pairs) { Set.new(ordered_pair1, ordered_pair2) }
      subject(:function) { Function.new(ordered_pairs) }

      context "element in domain points to two in range" do
        let(:ordered_pair2) { OrderedPair.new(1,4) }

        it "raises an error" do
          expect { Function.new(ordered_pairs) }.to raise_error(
            ArgumentError,
            "Not a function"
          )
        end
      end

      context "two elements in domain point to same in range" do
        let(:ordered_pair2) { OrderedPair.new(3,2) }

        it "properly initializes the function" do
          expect(function.instance_variable_get(:@hash).keys).to contain_exactly(
            ordered_pair1,
            ordered_pair2
          )
        end
      end

      context "without a codomain" do
        it "initializes the codomain as the range" do
          expect(function.instance_variable_get(:@codomain)).to eq(function.range)
        end
      end

      context "with a codomain" do
        let(:codomain) { Set.new(1,2) }
        let(:ordered_pairs) { Set.new(OrderedPair.new(1,1)) }

        subject(:function) { Function.new(ordered_pairs, codomain: codomain) }

        it "stores the codomain" do
          expect(function.instance_variable_get(:@codomain)).to eq(codomain)
        end

        context "codomain is not a superset of range" do
          let(:codomain) { Set.new(1,2,3) }
          subject(:function) { Function.new(ordered_pairs, codomain: codomain) }
        end

        context "codomain is not a set" do
          let(:codomain) { 5 }

          it "raises an error" do
            expect { Function.new(ordered_pairs, codomain: codomain) }.to raise_error(
              ArgumentError,
              "Codomain is not a BetterSet"
            )
          end
        end
      end
    end

    describe "#[]" do
      let(:ordered_pair) { OrderedPair.new(3,2) }
      subject(:function) { Function.new(Set.new(ordered_pair)) }

      it "returns the second element of the ordered pair with the input as its first element" do
        expect(function[3]).to eq(2)
      end

      context "input is not in the domain" do
        it "returns nil" do
          expect(function[0]).to eq(nil)
        end
      end
    end

    describe "#injective?" do
      context "for all x,y in dom(F), f(x) == f(y) && x = y" do
        let(:ordered_pair) { OrderedPair.new(3,2) }
        subject(:function) { Function.new(Set.new(ordered_pair)) }

        it "returns true" do
          expect(function.injective?).to be(true)
        end
      end

      context "there is an x,y in dom(F), f(x) == f(y) && x != y" do
        let(:ordered_pair) { OrderedPair.new(3,2) }
        let(:ordered_pair2) { OrderedPair.new(4,2) }
        let(:ordered_pairs) { Set.new(ordered_pair, ordered_pair2) }
        subject(:function) { Function.new(ordered_pairs) }

        it "returns false" do
          expect(function.injective?).to be(false)
        end
      end
    end

    describe "#surjective?" do
      let(:ordered_pair) { OrderedPair.new(3,2) }
      let(:ordered_pair2) { OrderedPair.new(4,2) }
      let(:ordered_pairs) { Set.new(ordered_pair, ordered_pair2) }

      context "for all y in range(F), there is an x in dom(F) s.t. f(x) == y" do
        subject(:function) { Function.new(ordered_pairs) }

        it "returns true" do
          expect(function.surjective?).to be(true)
        end
      end

      context "codomain does not equal range" do
        let(:codomain) { Set.new(2,3) }
        subject(:function) { Function.new(ordered_pairs, codomain: codomain) }

        it "returns false" do
          expect(function.surjective?).to be(false)
        end
      end
    end

    describe "bijective?" do
      let(:ordered_pair) { OrderedPair.new(3,2) }
      let(:ordered_pair2) { OrderedPair.new(4,5) }
      let(:ordered_pairs) { Set.new(ordered_pair, ordered_pair2) }
      subject(:function) { Function.new(ordered_pairs) }

      context "one-to-one" do
        context "onto" do
          it "returns true" do
            expect(function.injective?).to be(true)
            expect(function.surjective?).to be(true)
            expect(function.bijective?).to be(true)
          end
        end

        context "not onto" do
          let(:codomain) { Set.new(2,5,6) }
          subject(:function) { Function.new(ordered_pairs, codomain: codomain) }

          it "returns false" do
            expect(function.injective?).to be(true)
            expect(function.surjective?).to be(false)
            expect(function.bijective?).to be(false)
          end
        end
      end

      context "not one-to-one" do
        context "onto" do
          let(:ordered_pair) { OrderedPair.new(3,2) }
          let(:ordered_pair2) { OrderedPair.new(4,2) }

          it "returns false" do
            expect(function.injective?).to be(false)
            expect(function.surjective?).to be(true)
            expect(function.bijective?).to be(false)
          end
        end

        context "not onto" do
          let(:ordered_pair) { OrderedPair.new(3,2) }
          let(:ordered_pair2) { OrderedPair.new(4,2) }
          let(:codomain) { Set.new(2,3) }
          subject(:function) { Function.new(ordered_pairs, codomain: codomain) }

          it "returns false" do
            expect(function.injective?).to be(false)
            expect(function.surjective?).to be(false)
            expect(function.bijective?).to be(false)
          end
        end
      end
    end
  end
end
