class CommandLineBuilder

  # config is a hash containing the command line to build
  def initialize(config)
    @command_line = config[:command_line]
  end

  def build(build_args)
    begin
      output = `#{@command_line}`
      cmd_line_res = $?.exitstatus
      
      result = :failure
      result = :success if cmd_line_res == 0

      @result = {:id => build_args[:id], :logs => nil, :result => result}
    rescue => ex
      puts "exception: #{ex.message}"
      @result = {:id => build_args[:id], :logs => nil, :result => :failure}
    end
  
  end

  def result
    @result
  end

end