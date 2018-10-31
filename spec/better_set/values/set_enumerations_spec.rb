module BetterSet
  module Values
    RSpec.describe SetEnumerations do
      let(:initial_set) { Set.new }

      let(:dummy_class) do
        Class.new do
          include SetEnumerations

          def initialize(initial_set)
            @set = initial_set
          end

          delegate :to_a, :-, to: :set

          private

          attr_reader :set
        end
      end

      subject(:set) { dummy_class.new(initial_set) }

      describe "delegations" do
        it { should delegate_method(:all?).to(:to_a) }
        it { should delegate_method(:any?).to(:to_a) }
        it { should delegate_method(:find).to(:to_a) }
        it { should delegate_method(:none?).to(:to_a) }
        it { should delegate_method(:reduce).to(:to_a) }
      end

      describe "#each" do
        let(:initial_set) { Set.new(1,2) }

        it "evaluates the block against to_a and wraps the result in a set" do
          block = Proc.new { |element| element }
          expected_result = Set.new(*initial_set.to_a.each(&block))

          expect(set.each(&block)).to eq(expected_result)
        end
      end

      describe "#select" do
        let(:initial_set) { Set.new(1,2,3,4) }

        it "evaluates the block against to_a and wraps the result in a set" do
          expected_result = Set.new(*initial_set.to_a.select(&:even?))

          expect(set.select(&:even?)).to eq(expected_result)
        end
      end

      describe "#reject" do
        let(:initial_set) { Set.new(1,2,3,4) }

        it "evaluates the block against to_a and wraps the result in a set" do
          expected_result = Set.new(*initial_set.to_a.reject(&:even?))

          expect(set.reject(&:even?)).to eq(expected_result)
        end
      end

      describe "#map" do
        let(:initial_set) { Set.new(1,2,3,4) }

        it "evaluates the block against to_a and wraps the result in a set" do
          expected_result = Set.new(*initial_set.to_a.map(&:even?))

          expect(set.map(&:even?)).to eq(expected_result)
        end
      end

      describe "#partition" do
        let(:initial_set) { Set.new(1,2,3,4,5,6,7,8,9,10) }

        it "divides the given set by the supplied block" do
          even_set = initial_set.select(&:even?)
          odd_set = initial_set.select(&:odd?)

          expect(set.partition(&:even?)).to eq(Set.new(
            even_set,
            odd_set,
          ))
        end
      end
    end
  end
end
