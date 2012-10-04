class WebForm
  #belongs_to :web_app
  #has_many    :task_runs

  include Mongoid::Document
  include EntityHelper

  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :url, type: String
  field :action, type: String
  field :fields, type: String
  field :created_at, type: Time
  field :updated_at, type: Time 

  def to_s
    "#{self.class}: #{self.name} - #{self.url} -> #{self.action}"
  end

end
