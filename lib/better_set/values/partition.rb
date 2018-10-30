module BetterSet
  module Values
    class Partition
      def self.value(set, block)
        new(set, block).value
      end

      def initialize(set, block)
        @set = set
        @block = block
      end

      def value
        Set.new(truthy_set, falsy_set)
      end

      private

      def truthy_set
        @set.select { |element| @block.call(element) }
      end

      def falsy_set
        @set - truthy_set
      end
    end
  end
end
