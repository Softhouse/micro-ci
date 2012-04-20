lib = File.expand_path("../lib", File.dirname(__FILE__))

Dir[File.join(lib, "**/*.rb")].each {|f| require_relative f}
