class Host
  #as_many     :net_svcs
  #has_many     :domains
  #has_many     :physical_locations
  #has_many     :task_runs
  #validates_uniqueness_of :ip_address
  #validates_presence_of   :ip_address
  #validates_format_of :ip_address, :with => /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/

  include Mongoid::Document
  include EntityHelper
  
  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer   
  field :ip_address, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

  #
  # This method is highly questionable, but folks generally refer to a host
  # by its ip address(es), and thus, this makes tasks easier to code.
  #
  def name
    ip_address
  end

  def to_s
    "#{self.class}: #{self.ip_address}"
  end

end
