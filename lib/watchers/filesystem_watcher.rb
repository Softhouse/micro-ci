require 'directory_watcher'

class FilesystemWatcher
  

  def initialize(core, args)
    @core = core
    dw = DirectoryWatcher.new args[:path], :glob => args[:glob], :pre_load => true
    dw.interval = args[:interval] || 5.0
    dw.add_observer {|*args| args.each {|event| 
    		    files = event[:path]
    		    @core.notify({:files => files, :time => Time.now}) unless event[:type] == :stable }}
    dw.start
  end
end