require 'digest/sha1'

class Core

  attr_accessor :builder
  attr_accessor :logger

  def initialize
    @watchers = []
    @builder = nil
    @build_results = {}
  end

  def watchers
    @watchers
  end

  def notify(notification)
    id = generate_id
    @builder.build({:id => id, :notification => notification})
    current_result = @builder.result
    @build_results[id] = current_result
    @logger.log({:id => id, :time => notification[:time], :message => current_result})
  end

  def build_status
    @builder.run_status
  end

  def build_results
    @build_results
  end

  private
  def generate_id
    current_time = Time.now.to_s
    id = Digest::SHA1.hexdigest(current_time)[0,15]
  end

end