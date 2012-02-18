require "bundler"

class Bundle
  class << self
    def deps
      dependencies.map { |dep| Dep.new(dep.name) }
    end

    def rev(dep_name)
      dependencies.find { |dep| dep.name == dep_name }.requirement
    end

    def pin(dep_name, rev)
      dep = dependencies.find { |dep| dep.name == dep_name }
      dep.requirement.instance_variable_set(:@requirements, [Gem::Version.new(rev)])
      dep.instance_variable_set(:@requirement, nil)
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
