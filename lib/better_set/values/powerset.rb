require "better_set/values/subset_for_powerset_position"

module BetterSet
  module Values
    class Powerset
      def self.value(set)
        new(set).value
      end

      def initialize(set)
        @set = set
      end

      def value
        Set.new(*set_elements)
      end

      private

      def powerset_cardinality
        (2 ** @set.cardinality)
      end

      def set_elements
        Array.new(powerset_cardinality) do |position|
          SubsetForPowersetPosition.value(
            set: @set,
            position: position,
          )
        end
      end
    end
  end
end
