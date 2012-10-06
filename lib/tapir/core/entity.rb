require 'singleton'
module Tapir
  class Entity
    include Singleton
    #
    # TODO - this is used to find candidates for a task - this will need optimization
    #  or a better approach sooner rather than later
    #
    def all
      entities = []
      Entities::Domain.all.each {|x| entities << x } unless Entities::Domain.all == [] 
      Entities::Finding.all.each {|x| entities << x } unless Entities::Finding.all == []  
      Entities::Host.all.each {|x| entities << x } unless Entities::Host.all == [] 
      Entities::NetBlock.all.each {|x| entities << x } unless Entities::NetBlock.all == [] 
      Entities::NetSvc.all.each {|x| entities << x } unless Entities::NetSvc.all == []
      Entities::Organization.all.each {|x| entities << x } unless Entities::Organization.all == []
      Entities::PhysicalLocation.all.each {|x| entities << x } unless Entities::PhysicalLocation.all == []
      Entities::SearchString.all.each {|x| entities << x } unless Entities::SearchString.all == []
      Entities::User.all.each {|x| entities << x } unless Entities::User.all == []
      Entities::WebApp.all.each {|x| entities << x } unless Entities::WebApp.all == []
      Entities::WebForm.all.each {|x| entities << x } unless Entities::WebForm.all == []
      Entities::Image.all.each {|x| entities << x } unless Entities::Image.all == []
      Entities::Account.all.each {|x| entities << x } unless Entities::Account.all == []
      Entities::ParsableFile.all.each {|x| entities << x } unless Entities::ParsableFile.all == []
    entities
    end

    def first
      self.all.first
    end

    def last
      self.all.last
    end

    def tasks
      tasks = []
    end

  end
end
