require "better_set/values/initialize_relation"

module BetterSet
  class Relation < Set
    def initialize(ordered_pairs)
      @ordered_pairs = ordered_pairs
      super(initial_argument)
    end

    private

    def initial_argument
      Values::InitializeRelation.value(@ordered_pairs)
    end
  end
end
