require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.on("-p", "--path PATH", "The path to check for changes") do |p|
    options[:path] = p
  end
  opts.on("-c", "--command-line COMMANDLINE", "The command-line to run when a change has happened") do |c|
    options[:commandline] = c
  end
end.parse!

# core = Core.new
# core.builder = CommandLineBuilder.new {:command_line => options[:commandline]}
# core.logger = DummyLogger.new