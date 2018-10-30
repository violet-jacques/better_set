require "better_set/initializers/relation_initializer"
require "better_set/values/symmetry"
require "better_set/values/transitivity"
require "better_set/values/intransitivity"

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
        @ordered_pairs.member?(OrderedPair.new(element, element))
      end
    end

    def nonreflexive?
      !reflexive?
    end

    def irreflexive?
      domain.none? do |element|
        @ordered_pairs.member?(OrderedPair.new(element, element))
      end
    end

    def symmetric?
      Values::Symmetry.value(@ordered_pairs)
    end

    def antisymmetric?
      @ordered_pairs.all? do |ordered_pair|
        if @ordered_pairs.member?(OrderedPair.new(ordered_pair.second, ordered_pair.first))
          ordered_pair.second == ordered_pair.first
        else
          true
        end
      end
    end

    def asymmetric?
      @ordered_pairs.none? do |ordered_pair|
        @ordered_pairs.member?(OrderedPair.new(ordered_pair.second, ordered_pair.first))
      end
    end

    def transitive?
      Values::Transitivity.value(@ordered_pairs)
    end

    def nontransitive?
      !transitive?
    end

    def intransitive?
      Values::Intransitivity.value(@ordered_pairs)
    end

    def connected?
      domain.all? do |element|
        (domain - Set.new([element])).all? do |next_element|
          @ordered_pairs.member?(OrderedPair.new(element, next_element)) ||
            @ordered_pairs.member?(OrderedPair.new(next_element, element))
        end
      end
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
