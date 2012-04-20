require 'optparse'
lib = File.expand_path("lib", File.dirname(__FILE__))
Dir[File.join(lib, "**/*.rb")].each {|f| require_relative f}
require_relative 'spec/dummys/dummy_logger'


options = {}
OptionParser.new do |opts|
  opts.on("-p", "--path PATH", "The path to check for changes") do |p|
    options[:path] = p
  end
  opts.on("-c", "--command-line COMMANDLINE", "The command-line to run when a change has happened") do |c|
    options[:commandline] = c
  end
end.parse!

core = Core.new
core.builder = CommandLineBuilder.new({:command_line => options[:commandline]})
core.logger = DummyLogger.new
core.watchers << FilesystemWatcher.new(core, {:path => options[:path]})

puts "press any key to kill me"
gets