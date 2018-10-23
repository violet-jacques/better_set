require "better_set/values/powerset_position_flags"

module BetterSet
  module Values
    class SubsetForPowersetPosition
      def self.value(set:, position:)
        new(set, position).value
      end

      def initialize(set, position)
        @set = set
        @position = position
      end

      def value
        Set.new(set_elements)
      end

      private

      def flags
        PowersetPositionFlags.value(@position)
      end

      def set_elements
        flags.each_with_index.reduce(Array.new) do |memo, (flag, index)|
          if flag
            memo
          else
            [*memo, *@set.to_a[index]]
          end
        end
      end
    end
  end
end
