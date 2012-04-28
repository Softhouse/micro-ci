# encoding: utf-8
require 'optparse'
lib = File.expand_path("lib", File.dirname(__FILE__))
Dir[File.join(lib, "**/*.rb")].each {|f| require_relative f}
require_relative 'spec/dummys/dummy_logger'
require 'yaml'
 
options = YAML.load_file("config.yaml") || {}
optparse = OptionParser.new do |opts|
  opts.banner = 'µ-ci - The minimal CI for your convenience'
  opts.separator ""
  opts.separator "Usage: micro-ci [options]"
  opts.on("-p", "--path PATH", "The path to check for changes") do |p|
    options[:path] = p
  end
  opts.on("-c COMMANDLINE", "--commandline COMMANDLINE", "The command-line to run when a change has happened") do |c|
    options[:commandline] = c
  end
  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end

begin
  optparse.parse!
  mandatory = [:path, :commandline]
  missing = mandatory.select{ |param| options[param].nil? }
  if not missing.empty?
    puts "Missing options: #{missing.join(', ')}"
    puts optparse
    exit 
  end    
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  puts $!.to_s
  puts optparse
  exit
end

fwopts = {}
fwopts[:path] = options[:path] if options.has_key?(:path)
fwopts[:interval] = options[:interval] if options.has_key?(:interval)

core = Core.new
core.builder = CommandLineBuilder.new({:command_line => options[:commandline]})
core.logger = DummyLogger.new
core.watchers << FilesystemWatcher.new(core, fwopts)

puts "press any key to kill me"
gets