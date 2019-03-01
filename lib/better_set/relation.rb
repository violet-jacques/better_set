require "better_set/initializers/relation_initializer"
require "better_set/values/symmetry"
require "better_set/values/transitivity"
require "better_set/values/intransitivity"

module BetterSet
  class Relation < Set
    def initialize(ordered_pairs)
      @ordered_pairs = ordered_pairs
      super(*initial_argument)
    end

    def domain
      @domain ||= @ordered_pairs.map(&:first)
    end

    def range
      @range ||= @ordered_pairs.map(&:second)
    end

    def reflexive?
      @reflexive ||= (
        domain.all? do |element|
          @ordered_pairs.member?(OrderedPair.new(element, element))
        end
      )
    end

    def nonreflexive?
      @nonreflexive ||= !reflexive?
    end

    def irreflexive?
      @irreflexive ||= (
        domain.none? do |element|
          @ordered_pairs.member?(OrderedPair.new(element, element))
        end
      )
    end

    def symmetric?
      @symmetric ||= Values::Symmetry.value(@ordered_pairs)
    end

    def antisymmetric?
      @antisymmetric ||= (
        @ordered_pairs.all? do |ordered_pair|
          ordered_pair.antisymmetric_in?(@ordered_pairs)
        end
      )
    end

    def asymmetric?
      @asymmetric ||= (
        @ordered_pairs.none? do |ordered_pair|
          @ordered_pairs.member?(ordered_pair.inverse)
        end
      )
    end

    def transitive?
      @transitive ||= Values::Transitivity.value(@ordered_pairs)
    end

    def nontransitive?
      @nontransitive ||= !transitive?
    end

    def intransitive?
      @intransitive ||= Values::Intransitivity.value(@ordered_pairs)
    end

    def connected?
      @connected ||= (
        domain.all? do |element|
          (domain.remove(element)).all? do |next_element|
            ordered_pair = OrderedPair.new(element, next_element)

            ordered_pair.connected_in?(@ordered_pairs)
          end
        end
      )
    end

    def semi_connex?
      @semi_connex ||= (
        domain.cartesian_product(domain).all? do |ordered_pair|
          ordered_pair.semi_connex_in?(self)
        end
      )
    end

    def equivalence_relation?
      @equivalence_relation ||= reflexive? && symmetric? && transitive?
    end

    def union(other)
      new_ordered_pairs = @ordered_pairs.union(other)

      handle_ordered_pairs_given(other, new_ordered_pairs)
    end

    def intersection(other)
      new_ordered_pairs = @ordered_pairs.intersection(other)

      handle_ordered_pairs_given(other, new_ordered_pairs)
    end

    def difference(other)
      new_ordered_pairs = @ordered_pairs.difference(other)

      handle_ordered_pairs_given(other, new_ordered_pairs)
    end

    private

    def initial_argument
      Initializers::RelationInitializer.value(@ordered_pairs)
    end

    def function?
      domain.cardinality == @ordered_pairs.cardinality
    end

    def handle_ordered_pairs_given(other, ordered_pairs)
      if other.is_a?(Relation)
        Relation.new(ordered_pairs)
      else
        ordered_pairs
      end
    end
  end
end
