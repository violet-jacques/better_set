module BetterSet
  module Values
    class InitialHash
      NOT_ARRAY_ERROR_MESSAGE = "Argument must be Array class".freeze

      def self.value(array)
        new(array).value
      end

      def initialize(array)
        @array = array
      end

      def value
        raise_not_array_error unless initialized_with_array?

        create_hash
      end

      private

      def create_hash
        @array.reduce(Hash.new(false)) do |memo, element|
          add_unique_elements_to_hash(memo, element)
        end
      end

      def add_unique_elements_to_hash(hash, element)
        if hash.keys.include?(element)
          hash
        else
          hash.merge(element => true)
        end
      end

      def initialized_with_array?
        @array.class == Array
      end

      def raise_not_array_error
        raise ArgumentError, NOT_ARRAY_ERROR_MESSAGE
      end
    end
  end
end
