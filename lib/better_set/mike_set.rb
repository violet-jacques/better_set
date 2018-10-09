module BetterSet
  class MikeSet
    def initialize(array = [])
      @hash = Hash.new(false)

      merge_initial_argument(array)
    end

    def inspect
      if @hash.keys.include?("null")
        "<BetterSet: Ø>"
      else
        "<BetterSet: {#{@hash.keys.map { |key| key.inspect[1..-2] }.join(', ')}}>"
      end
    end

    private

    def merge_initial_argument(argument)
      if argument.class != Array
        raise ArgumentError, "Argument must be Array class"
      elsif argument.empty?
        @hash.update("null" => true)
      else
        merge_array(argument)
      end
    end

    def merge_array(array)
      @hash.merge!(array.map { |el| [el, true] }.to_h)
    end
  end
end
