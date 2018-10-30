module BetterSet
  module Values
    class CartesianProduct
      def self.value(domain, range)
        new(domain, range).value
      end

      def initialize(domain, range)
        @domain = domain.to_a
        @range = range.to_a
      end

      def value
        Relation.new(ordered_pairs)
      end

      private

      def ordered_pairs
        product.map do |pairs|
          OrderedPair.new(pairs.first, pairs.last)
        end
      end

      def product
        Set.new(*@domain.product(@range))
      end
    end
  end
end
