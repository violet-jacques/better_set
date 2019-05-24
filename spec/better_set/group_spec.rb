module BetterSet
  RSpec.describe Group do
    let(:set) { Set.new(1) }
    let(:group_law) { Proc.new { |a,b| a } }

    subject(:group) { Group.new(set, group_law) }

    describe "#initialize" do
      context "invalid group" do
        context "set is open with respect to group law" do
          let(:group_law) { Proc.new { |a,b| a + b } }

          it "raises an invalid group error" do
            expect { group }.to raise_error(
              ArgumentError,
              "Not a valid group",
            )
          end
        end

        context "set is not associative with respect to group law" do
          let(:set) { Set.new(1, 2) }
          let(:group_law) { Proc.new { |a,b| a**b } }

          it "raises an invalid group error" do
            expect { group }.to raise_error(
              ArgumentError,
              "Not a valid group",
            )
          end
        end

        context "there is no identity element" do
          let(:set) { Set.new(1, 2) }
          let(:group_law) do
            Proc.new do |a, b|
              if a == 1
                1
              else
                2
              end
            end
          end

          it "raises an invalid group error" do
            expect { group }.to raise_error(
              ArgumentError,
              "Not a valid group",
            )
          end
        end

        context "there is an element with no inverse element" do
          let(:set) { Set.new(1, 0.5, 0) }
          let(:group_law) do
            Proc.new do |a, b|
              [(1 - a), b].max
            end
          end

          it "raises an invalid group error" do
            expect { group }.to raise_error(
              ArgumentError,
              "Not a valid group",
            )
          end
        end
      end
    end

    describe "#identity_element" do
      let(:underlying_set) { Set.new(1, 2) }
      let(:group_law) do
        Proc.new { |a, b| [a, b].max }
      end

      let(:group) { Group.new(underlying_set, group_law) }
      subject(:identity_element) { group.identity_element }

      it "returns the element in the set such that for all other elements x, (x, identity_element) applied to the group law returns the identity element" do
        expect(identity_element).to eq(2)
      end
    end

    describe "#inspect" do
      let(:underlying_set) { Set.new(1, 2) }
      let(:group_law) do
        Proc.new { |a, b| [a, b].max }
      end
      let(:group) { Group.new(underlying_set, group_law) }
      subject(:inspect) { group.inspect }

      it "returns a string representation of the group" do
        expect(inspect).to eq("({1, 2}, •)")
      end
    end
  end
end
