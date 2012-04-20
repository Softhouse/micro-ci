require "spec_helper"

describe "filesystem_watcher" do
  before(:each) do
    @core = Core.new
    @core.logger = DummyLogger.new    
    @core.builder = DummyBuilder.new
    @test_dir = Dir::pwd + "/" + "test_filesystem_watcher"
    File.directory? @test_dir || Dir::rmdir(@test_dir)
    Dir::mkdir(@test_dir)
  end
  after(:each) do
    Dir[File.join(@test_dir, "**/*")].each {|f| File.delete(f)}
    Dir::rmdir(@test_dir)
  end
  it "see created file in watched dir" do
     @core.watchers << FilesystemWatcher.new(@core, {:path => @test_dir, :glob => "**/*", :interval => 0.1})
     filename = File.join(@test_dir, "test_file1")
     File.open(filename, 'a'){|f| f.puts ' '}
     sleep 1
     @core.logger.counter.should == 1
  end
end