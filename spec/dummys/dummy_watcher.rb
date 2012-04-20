class DummyWatcher

  def initialize(core)
    @core = core
  end

  # Dummy function to trigger a build
  # files is an array
  def trig(files)
    hash = {:files => files, :time => Time.now}
    @core.notify hash
  end

end
