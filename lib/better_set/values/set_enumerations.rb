require "better_set/values/partition"

module BetterSet
  module Values
    module SetEnumerations
      delegate :any?, :all?, :none?, :reduce, :*, to: :to_a

      def select(&block)
        Set.new(*to_a.select(&block))
      end

      def reject(&block)
        Set.new(*to_a.reject(&block))
      end

      def each(&block)
        Set.new(*to_a.each(&block))
      end

      def map(&block)
        Set.new(*to_a.map(&block))
      end

      def partition(&block)
        Partition.value(self, block)
      end
    end
  end
end
