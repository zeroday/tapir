module Tapir
class Tenant
  include Mongoid::Document
  include Mongoid::Timestamps
  
  validates_uniqueness_of :host  
end
end