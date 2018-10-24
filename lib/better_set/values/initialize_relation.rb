module BetterSet
  module Values
    class InitializeRelation
      def self.value(ordered_pairs)
        new(ordered_pairs).value
      end

      def initialize(ordered_pairs)
        @ordered_pairs = ordered_pairs
      end

      def value
        handle_incorrect_argument || initial_value
      end

      private

      def initial_value
        @ordered_pairs.to_a
      end

      def handle_incorrect_argument
        unless valid_argument?
          raise ArgumentError, "Argument must be a set of ordered pairs"
        end
      end

      def enumerable?
        @ordered_pairs.respond_to?("all?")
      end

      def valid_argument?
        enumerable? && set_of_ordered_pairs?
      end

      def set_of_ordered_pairs?
        @ordered_pairs.all? { |ordered_pair| ordered_pair?(ordered_pair) }
      end

      def ordered_pair?(object)
        object.is_a?(OrderedPair)
      end
    end
  end
end
