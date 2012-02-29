require "bundler"

class Bundle
  class << self
    def deps
      dependencies.map { |dep| Dep.new(dep.name) }
    end

    private

    def dependencies
      definition.dependencies
    end

    def definition
      Bundler.definition
    end
  end
end
