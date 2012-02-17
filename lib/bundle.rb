require "bundler"

class Bundle
  def deps
    Bundler.definition.dependencies.map(&:name)
  end
end
