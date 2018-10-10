module BetterSet
  class MikeSet
    def initialize(array = [])
      @hash = Hash.new(false)

      merge_initial_argument(array)
    end

    def inspect
      if keys.empty?
        "#<BetterSet: Ø>"
      else
        "#<BetterSet: {#{keys.inspect[1..-2]}}>"
      end
    end

    private

    def keys
      @keys ||= @hash.keys
    end

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
  end
end
