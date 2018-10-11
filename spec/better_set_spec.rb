RSpec.describe BetterSet do
  it "has a version number" do
    expect(BetterSet::VERSION).not_to be nil
  end

  describe ".new" do
    it "initializes a Set" do
      array = [1,2,3]

      expect(BetterSet.new).to be_a(BetterSet::Set)

      expect(BetterSet.new(array)).to eq(BetterSet::Set.new(array))
    end
  end

  describe ".[]" do
    it "initializes a Set" do
      expect(BetterSet[]).to be_a(BetterSet::Set)

      expect(BetterSet[1,2,3]).to eq(BetterSet::Set.new([1,2,3]))
    end
  end
end
