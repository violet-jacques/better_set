module BetterSet
  module Values
    RSpec.describe PartitionUpdateEvaluation do
      describe ".value" do
        let(:truthy_set) { Set.new([1]) }
        let(:falsy_set) { Set.new([2]) }
        let(:partition) { [truthy_set, falsy_set] }
        let(:element) { nil }
        let(:block) { nil }
        subject(:updated_partition) do
          PartitionUpdateEvaluation.value(
            partition,
            element,
            block
          )
        end

        context "passed element is true wrt given block" do
          let(:element) { 3 }
          let(:block) { Proc.new(&:odd?) }

          it "updates the first set of the partition with the element" do
            expect(updated_partition).to eq([
              Set.new([1,3]),
              Set.new([2])
            ])
          end
        end

        context "passed element is false wrt given block" do
          let(:element) { 4 }
          let(:block) { Proc.new(&:odd?) }

          it "updates the second (last) set of the partition with the element" do
            expect(updated_partition).to eq([
              Set.new([1]),
              Set.new([2,4])
            ])
          end
        end
      end
    end
  end
end
