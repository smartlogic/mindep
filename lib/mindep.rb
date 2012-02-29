require_relative "tests"

class Mindep
  def initialize(bundle)
    @bundle = bundle
  end

  def min
    bundle.deps.inject({}) do |min, dep|
      passing = dep.revs.take_while { |rev| Tests.passing? }
      min.merge(dep => passing.last)
    end
  end

  private

  attr_reader :bundle
end
