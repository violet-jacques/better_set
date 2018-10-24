require "better_set/values/initialize_ordered_pair"

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

    def symmetric?
      first == second
    end

    private

    def initial_ordered_pair_array
      Values::InitializeOrderedPair.value(first, second)
    end
  end
end
