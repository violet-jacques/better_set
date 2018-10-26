require "better_set/initializers/relation_initializer"

module BetterSet
  class Relation < Set
    def initialize(ordered_pairs)
      @ordered_pairs = ordered_pairs
      super(initial_argument)
    end

    private

    def initial_argument
      Initializers::RelationInitializer.value(@ordered_pairs)
    end
  end
end
