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

  private

  attr_reader :deps

  def contents
    ['source "https://rubygems.org"', *deps.map { |dep| %Q{gem "#{dep.name}", "#{dep.current_rev}"} }].join("\n")
  end
end
