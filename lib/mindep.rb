class Mindep
  def initialize(dep_list, dep_revs)
    @dep_list = dep_list
    @dep_revs = dep_revs
  end

  def min
    dep_list.inject({}) do |min, dep|
      passing, failing = revs(dep).partition { |rev| Tests.pass?(dep, rev) }
      min.merge(dep => passing.last)
    end
  end

  def revs(dep)
    dep_revs[dep_list.index(dep)]
  end

  private

  attr_reader :dep_list, :dep_revs
end
