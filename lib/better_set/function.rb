module BetterSet
  class Function < Relation
    NOT_A_FUNCTION = "Not a function".freeze
    NOT_A_CODOMAIN = "Codomain is not a BetterSet".freeze

    def initialize(ordered_pairs, codomain: nil)
      super(ordered_pairs)
      handle_improper_codomain(codomain)
      @codomain = codomain || range

      raise ArgumentError, NOT_A_FUNCTION unless function?
    end

    def [](input)
      @ordered_pairs.find { |pair| pair.first == input }&.second
    end

    def injective?
      domain.all? do |element|
        domain.all? do |next_element|
          if self[element] == self[next_element]
            element == next_element
          else
            true
          end
        end
      end
    end

    def surjective?
      @codomain.all? do |range_element|
        domain.any? do |domain_element|
          self[domain_element] == range_element
        end
      end
    end

    def bijective?
      injective? && surjective?
    end

    private

    def handle_improper_codomain(codomain)
      raise ArgumentError, NOT_A_CODOMAIN unless valid_codomain?(codomain)
    end

    def valid_codomain?(codomain)
      codomain.nil? || (codomain.is_a?(Set) && codomain.superset?(range))
    end
  end
end
