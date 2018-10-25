require "better_set/values/cartesian_product"
require "better_set/values/initialize_set"
require "better_set/values/powerset"
require "better_set/values/set_relations"

module BetterSet
  class Set
    delegate :all?, :any?, :none?, to: :to_a
    delegate :==, to: :set_relations
    delegate :cartesian_product, to: :set_relations
    delegate :proper_subset?, :proper_superset?, to: :set_relations
    delegate :subset?, :superset?, to: :set_relations
    delegate :union, :intersection, :difference, :-, to: :set_relations

    def self.big_union(*args)
      args.reduce(&:union)
    end

    def self.big_intersection(*args)
      args.reduce(&:intersection)
    end

    def initialize(array = [])
      @hash = Values::InitializeSet.value(array)
    end

    def cardinality
      to_a.length
    end

    def to_a
      @to_a ||= @hash.keys
    end

    def empty?
      cardinality.zero?
    end

    def member?(element)
      to_a.include?(element)
    end

    def inspect
      if empty?
        "Ø"
      else
        "{#{to_a.to_s[1..-2]}}"
      end
    end

    def to_s
      inspect
    end

    def powerset
      Values::Powerset.value(self)
    end

    private

    def set_relations
      @set_relations ||= Values::SetRelations.new(self)
    end
  end
end
