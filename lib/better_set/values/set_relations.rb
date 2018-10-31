module BetterSet
  module Values
    module SetRelations
      def ==(other)
        subset?(other) && same_cardinality_as(other)
      end

      def subset?(other)
        return false unless same_class_as(other)

        all? { |key| other.member?(key) }
      end

      def superset?(other)
        return false unless same_class_as(other)

        other.all? { |element| member?(element) }
      end

      def proper_subset?(other)
        subset?(other) && !same_cardinality_as(other)
      end

      def proper_superset?(other)
        superset?(other) && !same_cardinality_as(other)
      end

      def union(other)
        raise_argument_error unless same_class_as(other)

        self.class.new(
          *self,
          *other,
        )
      end

      def intersection(other)
        raise_argument_error unless same_class_as(other)

        self.class.new(*to_a.select { |element|
          other.member?(element)
        })
      end

      def difference(other)
        raise_argument_error unless same_class_as(other)

        self.class.new(*to_a.select { |element|
          !other.member?(element)
        })
      end

      def -(other)
        difference(other)
      end

      def cartesian_product(other)
        raise_argument_error unless same_class_as(other)

        CartesianProduct.value(self, other)
      end

      private

      def same_cardinality_as(other)
        return false unless same_class_as(other)

        cardinality == other.cardinality
      end

      def same_class_as(other)
        other.is_a?(Set)
      end

      def raise_argument_error
        raise ArgumentError, "Argument must be a BetterSet"
      end
    end
  end
end
