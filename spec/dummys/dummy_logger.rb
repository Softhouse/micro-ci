class DummyLogger
  attr_reader :counter

  def initialize
    @counter = 0
  end

  def log(message)
    @counter += 1 
  end

end