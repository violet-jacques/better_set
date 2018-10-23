module BetterSet
  module Values
    RSpec.describe InitialHash do
      describe ".value" do
        let(:array) { [1,"h", 3] }
        subject(:hash) { InitialHash.value(array) }

        it "creates a hash from the passed in array" do
          expected_hash = {
            1 => true,
            "h" => true,
            3 => true
          }

          expect(hash).to eq(expected_hash)
        end

        context "passed value not an array" do
          let(:array) { "sup" }

          it "raises an error" do
            expect do
              InitialHash.value(array)
            end.to raise_error(
              ArgumentError,
              "Argument must be Array class",
            )
          end
        end

        context "array contains dupes" do
          let(:array) { [1,1, "h", "h", 3, 3] }

          it "does not encode the dupes in the hash" do
            expected_hash = {
              1 => true,
              "h" => true,
              3 => true,
            }

            expect(hash).to eq(expected_hash)
          end

          context "regardless of class" do
            let(:array) do
              [Set.new, Set.new, { "foo" => "bar" }, { "foo" => "bar" } ]
            end

            it "does not encode the dupes in the hash" do
              expect(hash.keys).to contain_exactly(
                Set.new,
                { "foo" => "bar" },
              )
            end
          end
        end
      end
    end
  end
end
