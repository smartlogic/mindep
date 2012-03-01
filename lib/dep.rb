require "gems"

class Dep
  attr_reader :name

  def initialize(name, rev = nil)
    @name = name
    @rev = rev
  end

  def revs
    @revs ||= Gems.versions(name).map { |rev| rev["number"] }
  end

  def rev
    @rev || revs.first
  end

  def next
    Dep.new(name, next_rev) if next_rev
  end

  private

  def next_rev
    revs[revs.index(rev) + 1]
  end
end
