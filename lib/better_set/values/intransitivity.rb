module BetterSet
  module Values
    class Intransitivity
      def self.value(ordered_pairs)
        new(ordered_pairs).value
      end

      def initialize(ordered_pairs)
        @ordered_pairs = ordered_pairs
      end

      def value
        @ordered_pairs.none? do |ordered_pair|
          range_pairs = range_pairs_for(ordered_pair)

          range_pairs.any? do |range_pair|
            @ordered_pairs.member?(OrderedPair.new(ordered_pair.first, range_pair.second))
          end
        end
      end

      private

      def range_pairs_for(ordered_pair)
        @ordered_pairs.select { |pair| pair.first == ordered_pair.second }
      end
    end
  end
end
