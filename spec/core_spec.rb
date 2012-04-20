require "spec_helper"


describe "core" do
  before(:each) do
    @core = Core.new
  end
  it "can add a watcher" do
    @core.watchers << DummyWatcher.new(@core)

    @core.watchers.size.should == 1
  end

  it "can add a builder" do
    builder = DummyBuilder.new
    @core.builder = builder

    @core.builder.should equal(builder)
  end

  describe "with a watcher and builder" do
    before(:each) do
      @core.watchers << DummyWatcher.new(@core)
      @core.builder = DummyBuilder.new
      @core.logger = DummyLogger.new
    end
    
    it "notifies the builder when the watcher triggers" do
      modified_files = ["file1/file2.rb", "dir2/file3.rb"]
      @core.watchers[0].trig modified_files

      builder = @core.builder

      builder.current_result[:id].should_not == nil
    end

    it "should present build results" do
      modified_files = ["file.rb"]
      @core.watchers[0].trig modified_files

      builder = @core.builder

      current_build_result = @core.build_results[builder.current_result[:id]]

      current_build_result.should equal(builder.current_result)
      @core.logger.counter.should == 1
    end

  end

end