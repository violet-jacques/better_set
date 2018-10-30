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
        subset
      end

      private

      def flags
        PowersetPositionFlags.value(@position)
      end

      def subset
        flags.each_with_index.reduce(Set.new) do |memo, (flag, index)|
          if flag
            memo
          else
            memo.add(@set.to_a[index])
          end
        end
      end
    end
  end
end
