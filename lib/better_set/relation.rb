require "better_set/initializers/relation_initializer"
require "better_set/values/symmetry"

module BetterSet
  class Relation < Set
    def initialize(ordered_pairs)
      @ordered_pairs = ordered_pairs
      super(initial_argument)
    end

    def domain
      @ordered_pairs.map(&:first)
    end

    def range
      @ordered_pairs.map(&:second)
    end

    def reflexive?
      domain.all? do |element|
        @ordered_pairs.member?(OrderedPair.new(element,element))
      end
    end

    def symmetric?
      Values::Symmetry.value(@ordered_pairs)
    end

    private

    def initial_argument
      Initializers::RelationInitializer.value(@ordered_pairs)
    end

    def function?
      domain.cardinality == @ordered_pairs.cardinality
    end
  end
end
