# vim FTW
Pry.config.editor = "mvim --nofork"

# Prompt with ruby version
Pry.prompt = [proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

# awesome print
#require 'awesome_print'
#Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }

# Toys methods
# Stealed from https://gist.github.com/807492
class Array
  def self.toy(n=10, &block)
    block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
  end
end

class Hash
  def self.toy(n=10)
    Hash[Array.toy(n).zip(Array.toy(n){|c| (96+(c+1)).chr})]
  end
end

cs = Pry::CommandSet.new do
  import Pry::Commands
  command "lm","Alias for ls -m" do |args|
   run "ls", "-m #{args}"
  end
  command "lM", "Alias for ls -M" do |args|
   run "ls", "-M #{args}"
  end
end

Pry.config.commands = cs
