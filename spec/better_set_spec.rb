RSpec.describe BetterSet do
  it "has a version number" do
    expect(BetterSet::VERSION).not_to be nil
  end

  describe ".new" do
    it "initializes a MikeSet" do
      expect(BetterSet.new).to be_a(BetterSet::MikeSet)
    end
  end

  describe ".[]" do
    it "initializes a MikeSet" do
      expect(BetterSet[]).to be_a(BetterSet::MikeSet)
    end
  end
end
