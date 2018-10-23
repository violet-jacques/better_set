module BetterSet
  module Values
    RSpec.describe SubsetForPowersetPosition do
      describe ".value" do
        it "returns a subset of the passed set based on the passed position" do
          set = Set.new([1,2])
          position = 0
          position2 = 1
          position3 = 2
          position4 = 3

          expect(SubsetForPowersetPosition.value(
            set: set,
            position: position
          )).to eq(Set.new)

          expect(SubsetForPowersetPosition.value(
            set: set,
            position: position2
          )).to eq(Set.new([1]))

          expect(SubsetForPowersetPosition.value(
            set: set,
            position: position3
          )).to eq(Set.new([2]))

          expect(SubsetForPowersetPosition.value(
            set: set,
            position: position4
          )).to eq(Set.new([1,2]))
        end
      end
    end
  end
end
