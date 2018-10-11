module BetterSet
  class MikeSet
    def initialize(array = [])
      @hash = Hash.new(false)

      merge_initial_argument(array)
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
        "#<BetterSet: Ø>"
      else
        "#<BetterSet: {#{to_a.to_s[1..-2]}}>"
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
      unless same_class_as(other)
        raise ArgumentError, "Argument must be a BetterSet"
      else
        MikeSet.new([
          *self.to_a,
          *other.to_a,
        ])
      end
    end

    private

    def merge_initial_argument(argument)
      if argument.class != Array
        raise ArgumentError, "Argument must be Array class"
      else
        merge_array(argument)
      end
    end

    def merge_array(array)
      @hash.merge!(array.map { |el| [el, true] }.to_h)
    end

    def same_cardinality_as(other)
      return false unless same_class_as(other)

      cardinality == other.cardinality
    end

    def same_class_as(other)
      other.class.name == self.class.name
    end
  end
end
