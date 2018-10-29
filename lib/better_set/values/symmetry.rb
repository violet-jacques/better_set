module BetterSet
  module Values
    class Symmetry
      def self.value(ordered_pairs)
        new(ordered_pairs).value
      end

      def initialize(ordered_pairs)
        @ordered_pairs = ordered_pairs
      end

      def value
        if ordered_pairs.empty?
          true
        elsif ordered_pairs.member?(inverse_pair)
          Symmetry.value(new_ordered_pairs)
        else
          false
        end
      end

      private

      attr_reader :ordered_pairs

      def ordered_pair
        @ordered_pair ||= ordered_pairs.to_a.first
      end

      def inverse_pair
        @inverse_pair ||= OrderedPair.new(ordered_pair.second, ordered_pair.first)
      end

      def new_ordered_pairs
        ordered_pairs - Set.new([ordered_pair, inverse_pair])
      end
    end
  end
end
