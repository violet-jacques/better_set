require "better_set/values/partition_update_evaluation"

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
        Set.new(set_elements)
      end

      private

      def set_elements
        @set.reduce([Set.new, Set.new]) do |memo, element|
          PartitionUpdateEvaluation.value(
            memo,
            element,
            @block
          )
        end
      end
    end
  end
end
