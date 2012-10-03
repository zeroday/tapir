class User
  #belongs_to  :organization
  #has_many    :physical_locations
  #has_many    :task_runs
  #has_many    :accounts
  #validates_presence_of :usernames
  include Mongoid::Document
  include EntityHelper

  #serialize :usernames
  
  before_save :default_values, :cleanup_usernames 
  after_create :set_usernames_empty
  #after_save :log

  field :status, type: String
  field :confidence, type: Integer  
  field :first_name, type: String
  field :last_name, type: String
  field :middle_name, type: String
  field :email_addresses, type: String
  field :usernames, type: String
  field :first_name, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

  def to_s
    "#{self.class}: #{self.first_name} #{self.last_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def name 
    full_name
  end

private

  def default_values
    self.usernames ||= []
  end
  
  def set_usernames_empty
    self.usernames.uniq!
    self.save!
  end

  #
  # Do some basic cleanup on the usernames. Make sure they're unique, and
  # that they've been created without spaces
  #
  def cleanup_usernames
     
    #
    # Handle a string of comma separated (coming from the webui
    #
    self.usernames = self.usernames.split(",") if self.usernames.kind_of? String

    #
    # Make sure there's no spaces in the usernames
    #
    self.usernames.each {|u| u.gsub!(/\s+/, "")}
    
    #
    # Make sure all usernames are lowercase
    #
    self.usernames.each {|u| u.downcase!}
    
    #
    # Make sure we don't have multiple same usernames
    #
    self.usernames.uniq!
  end

  def log
    TapirLogger.instance.log self.to_s
  end

end
