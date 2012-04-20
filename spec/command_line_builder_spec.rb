describe "command line builder" do
  before(:each) do
    notification = {:files => ["file.rb"], :time => Time.now}
    @build_args = {:id => "ASDF1234", :notification => notification}
  end

  describe "for a failing build" do
    before(:each) do
      @builder = CommandLineBuilder.new({:command_line => "spec/command_line_builder_programs/failing_program.sh"})
      @builder.build(@build_args)
    end

    it "should signal that the build failed" do
      @builder.result[:result].should == :failure
    end
  end

  describe "a successful build" do
    before(:each) do
      @builder = CommandLineBuilder.new({:command_line => "spec/command_line_builder_programs/successful_program.sh"})
      @builder.build(@build_args)
    end

    it "should signal that the build was a success" do
      @builder.result[:result].should == :success
    end

  end
  
  
end