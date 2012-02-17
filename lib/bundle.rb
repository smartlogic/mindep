require "bundler"

class Bundle
  def self.deps
    Bundler.definition.dependencies.map(&:name)
  end
end
