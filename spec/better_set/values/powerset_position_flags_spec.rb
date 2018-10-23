module BetterSet
  module Values
    RSpec.describe PowersetPositionFlags do
      describe ".value" do
        it "returns an array of bools based on the binary form of the int" do
          integer = 0
          integer2 = 1
          integer3 = 2
          integer4 = 3

          expect(PowersetPositionFlags.value(integer)).to eq([true])
          expect(PowersetPositionFlags.value(integer2)).to eq([false])
          expect(PowersetPositionFlags.value(integer3)).to eq([true, false])
          expect(PowersetPositionFlags.value(integer4)).to eq([false, false])
        end
      end
    end
  end
end
