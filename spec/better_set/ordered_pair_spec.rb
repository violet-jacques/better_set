module BetterSet
  RSpec.describe OrderedPair do
    let(:first) { 1 }
    let(:second) { 2 }
    subject(:ordered_pair) { OrderedPair.new(first, second) }

    describe "initialize" do
      it "initializes first with the first argument" do
        expect(ordered_pair.first).to eq(first)
      end

      it "initializes second with the second argument" do
        expect(ordered_pair.second).to eq(second)
      end

      it "creates a set out of these as you would expect" do
        expect(ordered_pair.instance_variable_get(:@hash).keys).to eq([
          Set.new([first]),
          Set.new([first, second])
        ])
      end
    end

    describe "#inspect" do
      it "returns stringified versions of its coordinates in angled brackets" do
        expect(ordered_pair.inspect).to eq("<1, 2>")
      end
    end

    describe "#reflexive?" do
      context "first and second are identical" do
        let(:second) { first }

        it "returns true" do
          expect(ordered_pair.reflexive?).to be(true)
        end
      end

      context "first and second are not identical" do
        let(:first) { 1 }
        let(:second) { 2 }

        it "returns false" do
          expect(ordered_pair.reflexive?).to be(false)
        end
      end
    end
  end
end
