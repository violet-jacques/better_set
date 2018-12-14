require "better_set/initializers/ordered_pair_initializer"

module BetterSet
  class OrderedPair < Set
    attr_reader :first, :second

    def initialize(first, second)
      @first = first
      @second = second
      super(*initial_ordered_pair_set)
    end

    def inspect
      "<#{first.to_s}, #{second.to_s}>"
    end

    def reflexive?
      first == second
    end

    def inverse
      @inverse ||= self.class.new(second, first)
    end

    def injective_in?(function)
      return true unless function[first] == function[second]

      reflexive?
    end

    def semi_connex_in?(relation)
      return true unless reflexive? && !relation.member?(self)

      relation.member?(inverse)
    end

    def antisymmetric_in?(relation)
      return true unless relation.member?(inverse)

      reflexive?
    end

    def connected_in?(relation)
      relation.member?(self) || relation.member?(inverse)
    end

    private

    def initial_ordered_pair_set
      Initializers::OrderedPairInitializer.value(first, second)
    end
  end
end
