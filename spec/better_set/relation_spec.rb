module BetterSet
  RSpec.describe Relation do
    let(:ordered_pair) { OrderedPair.new(1,2) }
    let(:ordered_pairs) { Set.new([ordered_pair]) }
    subject(:relation) { Relation.new(ordered_pairs) }

    describe "initialize" do
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
  end
end
