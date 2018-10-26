module BetterSet
  module Values
    class PartitionUpdateEvaluation
      def self.value(partition, element, evaluator)
        new(partition, element, evaluator).value
      end

      def initialize(partition, element, evaluator)
        @partition = partition
        @element = element
        @evaluator = evaluator
      end

      def value
        updated_partition
      end

      private

      def updated_partition
        if @evaluator.call(@element)
          [updated_truthy_set, falsy_set]
        else
          [truthy_set, updated_falsy_set]
        end
      end

      def truthy_set
        @truthy_set ||= @partition.first
      end

      def falsy_set
        @falsy_set ||= @partition.last
      end

      def updated_truthy_set
        Set.new([*truthy_set.to_a, @element])
      end

      def updated_falsy_set
        Set.new([*falsy_set.to_a, @element])
      end
    end
  end
end
