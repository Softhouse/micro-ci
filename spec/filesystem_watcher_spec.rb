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
     @core.watchers << FilesystemWatcher.new(@core, {:path => @test_dir, :interval => 0.1})
     filename = File.join(@test_dir, "test_file1")
     File.open(filename, 'a'){|f| f.puts ' '}
     sleep 2
     @core.logger.counter.should == 2
  end
  it "see only specific file in dir" do
     @core.watchers << FilesystemWatcher.new(@core, {:path => @test_dir, :glob => "*.rb", :interval => 0.1})
     filename = File.join(@test_dir, "test_file1.rb")
     File.open(filename, 'a'){|f| f.puts ' '}
     filename2 = File.join(@test_dir, "test_file2.txt")
     File.open(filename2, 'a'){|f| f.puts ' '}
     sleep 3
     @core.logger.counter.should == 2
  end
end