require "gems"

class Dep
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def revs
    Gems.versions(@gem_name).map { |rev| rev["number"] }
  end
end
