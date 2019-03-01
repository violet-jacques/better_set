require "better_set/values/cartesian_product"
require "better_set/initializers/set_initializer"
require "better_set/values/powerset"
require "better_set/values/set_relations"
require "better_set/values/set_enumerations"

module BetterSet
  class Set
    include Values::SetEnumerations
    include Values::SetRelations

    def self.big_union(*args)
      args.reduce(&:union)
    end

    def self.big_intersection(*args)
      args.reduce(&:intersection)
    end

    def initialize(*args)
      @hash = Initializers::SetInitializer.value(args)
    end

    def cardinality
      to_a.length
    end

    def add(element)
      union(Set.new(element))
    end

    def remove(element)
      difference(Set.new(element))
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

    def arbitrary_element
      @arbitrary_element ||= to_a.sample
    end
  end
end
