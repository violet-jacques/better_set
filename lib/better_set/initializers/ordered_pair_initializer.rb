module BetterSet
  module Initializers
    class OrderedPairInitializer
      def self.value(first, second)
        new(first, second).value
      end

      def initialize(first, second)
        @first = first
        @second = second
      end

      def value
        [first_to_set, second_to_set]
      end

      private

      def first_to_set
        Set.new([@first])
      end

      def second_to_set
        Set.new([@first, @second])
      end
    end
  end
end
