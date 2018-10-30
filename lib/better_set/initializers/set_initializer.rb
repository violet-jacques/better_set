module BetterSet
  module Initializers
    class SetInitializer
      def self.value(array)
        new(array).value
      end

      def initialize(array)
        @array = array
      end

      def value
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
    end
  end
end
