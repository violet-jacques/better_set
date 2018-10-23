require "better_set/values/initial_ordered_pair_array"

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

    private

    def initial_ordered_pair_array
      Values::InitialOrderedPairArray.value(@first, @second)
    end
  end
end
