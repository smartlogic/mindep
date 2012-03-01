require "fileutils"

class Gemfile
  def initialize(deps)
    @deps = deps
  end

  def write
    FileUtils.mkdir_p "gemfiles"
    File.open("gemfiles/minimum_dependencies", "w+") do |f|
      f.write contents
    end
  end

  def next
    next_deps = deps.dup
    i = next_deps.index { |dep| dep.next }
    next_deps[i] = next_deps[i].next
    Gemfile.new(next_deps)
  end

  private

  attr_reader :deps

  def contents
    ['source "https://rubygems.org"', *deps.map { |dep| %Q{gem "#{dep.name}", "#{dep.rev}"} }].join("\n")
  end
end
