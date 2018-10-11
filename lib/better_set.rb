require "better_set/version"
require "better_set/set"

module BetterSet
  def self.[](*array)
    self.new(array)
  end

  def self.new(array = [])
    Set.new(array)
  end
end
