require "spec_helper"

describe "core" do
  before(:each) do
    @core = Core.new
  end
  it "can add a watcher" do
    @core.watchers << DirectoryWatcher.new

    @core.watchers.size.should == 1
  end
end