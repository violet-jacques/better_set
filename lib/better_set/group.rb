module BetterSet
  class Group
    def initialize(underlying_set, group_law)
      @underlying_set = underlying_set
      @group_law = group_law
      raise ArgumentError, "Not a valid group" unless closed? && associative? && identity_element? && inverse_element?
    end

    def identity_element
      @identity_element ||= (
        @underlying_set.find do |element|
          @underlying_set.all? do |next_element|
            @group_law.call(element, next_element) == element &&
              @group_law.call(next_element, element) == element
          end
        end
      )
    end

    def inspect
      "(#{@underlying_set}, •)"
    end

    private

    def closed?
      @underlying_set.all? do |element|
        @underlying_set.all? do |next_element|
          @underlying_set.member?(@group_law.call(element, next_element))
        end
      end
    end

    def associative?
      @underlying_set.all? do |element|
        @underlying_set.all? do |next_element|
          @underlying_set.all? do |final_element|
            left = @group_law.call(@group_law.call(element, next_element), final_element)
            right = @group_law.call(element, @group_law.call(next_element, final_element))

            left == right
          end
        end
      end
    end

    def identity_element?
      !identity_element.nil?
    end

    def inverse_element?
      @underlying_set.all? do |element|
        @underlying_set.any? do |next_element|
          @group_law.call(element, next_element) == identity_element &&
            @group_law.call(next_element, element) == identity_element
        end
      end
    end
  end
end
