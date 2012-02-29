require "bundler"

class Bundle
  class << self
    def deps
      dependencies.map { |dep| Dep.new(dep.name) }
    end

    def rev(dep_name)
      dependencies.find { |dep| dep.name == dep_name }.requirement
    end

    def gemfile
      ['source "https://rubygems.org"', *deps.map { |dep| %Q{gem "#{dep.name}", "#{dep.current_rev}"} }].join("\n")
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
