module BetterSet
  module Values
    class PowersetPositionFlags
      def self.value(powerset_position)
        new(powerset_position).value
      end

      def initialize(powerset_position)
        @powerset_position = powerset_position
      end

      def value
        normalized_flags
      end

      private

      def normalized_flags
        flags.map(&:even?)
      end

      def flags
        normalized_binary_array.map(&:to_i)
      end

      def normalized_binary_array
        normalized_binary.split("")
      end

      def binary
        @powerset_position.to_s(2)
      end

      def normalized_binary
        binary.reverse
      end
    end
  end
end
