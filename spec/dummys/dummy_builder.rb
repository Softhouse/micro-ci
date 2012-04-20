class DummyBuilder

  # Dummy attributes to fetch results
  attr_accessor :current_run_status
  attr_accessor :current_result

  def initialize
    @current_run_status = :idle
  end

  def build(build_args)
    @current_run_status = :running
    @id = build_args[:id]
    #build...
    @current_result = {:id => build_args[:id], :logs => nil, :result => :success}
    @current_run_status = :idle
  end

  def run_status
    return @current_run_status
  end

  def result
    return @current_result
  end

end
