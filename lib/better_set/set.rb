module BetterSet
  class Set
    def self.big_union(*args)
      args.reduce(&:union)
    end

    def self.big_intersection(*args)
      args.reduce(&:intersection)
    end

    def initialize(array = [])
      @hash = merge_initial_array(array).freeze
    end

    def cardinality
      to_a.length
    end

    def to_a
      @hash.keys
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

    def ==(other)
      subset?(other) && same_cardinality_as(other)
    end

    def subset?(other)
      return false unless same_class_as(other)

      to_a.all? { |key| other.member?(key) }
    end

    def superset?(other)
      return false unless same_class_as(other)

      other.to_a.all? { |element| member?(element) }
    end

    def proper_subset?(other)
      subset?(other) && !same_cardinality_as(other)
    end

    def proper_superset?(other)
      superset?(other) && !same_cardinality_as(other)
    end

    def union(other)
      raise_argument_error unless same_class_as(other)

      self.class.new([
        *self.to_a,
        *other.to_a,
      ])
    end

    def intersection(other)
      raise_argument_error unless same_class_as(other)

      self.class.new(self.to_a.select { |element|
        other.member?(element)
      })
    end

    def difference(other)
      raise_argument_error unless same_class_as(other)

      self.class.new(self.to_a.select { |element|
        !other.member?(element)
      })
    end

    def -(other)
      difference(other)
    end

    private

    def merge_initial_array(array)
      if array.class != Array
        raise ArgumentError, "Argument must be Array class"
      else
        array.reduce(Hash.new(false)) do |memo, element|
          memo.merge(element => true)
        end
      end
    end

    def same_cardinality_as(other)
      return false unless same_class_as(other)

      cardinality == other.cardinality
    end

    def same_class_as(other)
      other.class.name == self.class.name
    end

    def raise_argument_error
      raise ArgumentError, "Argument must be a BetterSet"
    end
  end
end
