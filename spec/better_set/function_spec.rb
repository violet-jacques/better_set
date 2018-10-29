module BetterSet
  RSpec.describe Function do
    describe "initialization" do
      let(:ordered_pair1) { OrderedPair.new(1,2) }
      let(:ordered_pair2) { OrderedPair.new(3,4) }
      let(:ordered_pairs) { Set.new([ordered_pair1, ordered_pair2]) }
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
    end
  end
end
