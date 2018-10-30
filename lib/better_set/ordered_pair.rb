require "better_set/initializers/ordered_pair_initializer"

module BetterSet
  class OrderedPair < Set
    attr_reader :first, :second

    def initialize(first, second)
      @first = first
      @second = second
      super(initial_ordered_pair_array)
    end

    def inspect
      "<#{first.to_s}, #{second.to_s}>"
    end

    def reflexive?
      first == second
    end

    private

    def initial_ordered_pair_array
      Initializers::OrderedPairInitializer.value(first, second)
    end
  end
end
