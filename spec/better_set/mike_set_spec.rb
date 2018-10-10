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
          expect(set.instance_variable_get(:@hash)).to(eq(
            "justine" => true,
          ))
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
