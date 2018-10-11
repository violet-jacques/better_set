require "better_set/version"
require "better_set/mike_set"

module BetterSet
  def self.[](*array)
    self.new(array)
  end

  def self.new(array = [])
    MikeSet.new(array)
  end
end
