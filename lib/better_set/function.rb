module BetterSet
  class Function < Relation
    NOT_A_FUNCTION = "Not a function".freeze

    def initialize(ordered_pairs)
      super(ordered_pairs)

      raise ArgumentError, NOT_A_FUNCTION unless function?
    end
  end
end
