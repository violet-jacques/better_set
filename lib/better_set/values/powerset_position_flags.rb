module BetterSet
  module Values
    class PowersetPositionFlags
      EMPTY_STRING = "".freeze
      RADIX = 2

      def self.value(powerset_position)
        new(powerset_position).value
      end

      def initialize(powerset_position)
        @powerset_position = powerset_position
      end

      def value
        flags
          .map(&:to_i)
          .map(&:zero?)
      end

      private

      def flags
        normalized_binary_string.split(EMPTY_STRING)
      end

      def binary_representation_of_position
        @powerset_position.to_s(RADIX)
      end

      def normalized_binary_string
        binary_representation_of_position.reverse
      end
    end
  end
end
