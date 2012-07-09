class Domain
  #belongs_to :organization
  #has_many   :hosts
  #has_many   :netblocks
  #has_many   :task_runs
  #validates_uniqueness_of :name
  #validates_presence_of   :name
  after_save :log
  
  include ModelHelper

    key :status, String
    key :record_created_on, Time
    key :record_updated_on, Time
    key :record_expires_on, Time
    key :disclaimer, String 
    key :registrar_name, String
    key :registrar_org, String
    key :registrar_url, String
    key :referral_whois, String
    key :registered, String
    key :available, String
    #key :organization_id, Integer
    #key :host_id, Inteer
    key :created_at, Time
    key :updated_at, Time
  

  def to_s
    "#{self.class}: #{self.name}"
  end

private

  def log
    TapirLogger.instance.log self.to_s
  end

end
