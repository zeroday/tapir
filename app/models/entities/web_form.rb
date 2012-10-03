class WebForm
  #belongs_to :web_app
  #has_many    :task_runs
  #after_save :log

  include Mongoid::Document
  include EntityHelper

  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :url, type: String
  field :action, type: String
  field :fields, type: String

  def to_s
    "#{self.class}: #{self.name} - #{self.url} -> #{self.action}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end
