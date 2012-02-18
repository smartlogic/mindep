require "gems"

class Dep
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def revs
    Gems.versions(name).map { |rev| rev["number"] }
  end

  def current_rev
    revs[@current_rev ||= 0]
  end

  def downgrade!
    @current_rev =+ 1
    current_rev
  end
end
