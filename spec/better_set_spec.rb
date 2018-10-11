RSpec.describe BetterSet do
  it "has a version number" do
    expect(BetterSet::VERSION).not_to be nil
  end

  describe ".new" do
    it "initializes a MikeSet" do
      array = [1,2,3]

      expect(BetterSet.new).to be_a(BetterSet::MikeSet)

      expect(BetterSet.new(array)).to eq(BetterSet::MikeSet.new(array))
    end
  end

  describe ".[]" do
    it "initializes a MikeSet" do
      expect(BetterSet[]).to be_a(BetterSet::MikeSet)

      expect(BetterSet[1,2,3]).to eq(BetterSet::MikeSet.new([1,2,3]))
    end
  end
end
