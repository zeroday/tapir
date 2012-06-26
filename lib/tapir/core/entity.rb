  #module Tapir

require 'singleton'

class Entity
  include Singleton
  #
  # TODO - this is used to find candidates for a task - this will need optimization
  #  or a better approach sooner rather than later
  #
  def all
    entitys = []
    Domain.all.each {|x| entitys << x } unless Domain.all == [] 
    Finding.all.each {|x| entitys << x }  unless Finding.all == []  
    Host.all.each {|x| entitys << x }  unless Host.all == [] 
    NetBlock.all.each {|x| entitys << x }  unless NetBlock.all == [] 
    NetSvc.all.each {|x| entitys << x }  unless NetSvc.all == []
    Organization.all.each {|x| entitys << x }  unless Organization.all == []
    PhysicalLocation.all.each {|x| entitys << x }   unless PhysicalLocation.all == []
    SearchString.all.each {|x| entitys << x }  unless SearchString.all == []
    User.all.each {|x| entitys << x }  unless User.all == []
    WebApp.all.each {|x| entitys << x }  unless WebApp.all == []
    WebForm.all.each {|x| entitys << x }  unless WebForm.all == []
    Image.all.each {|x| entitys << x }  unless Image.all == []
    Account.all.each {|x| entitys << x }  unless Account.all == []
    ParsableFile.all.each {|x| entitys << x }  unless ParsableFile.all == []
  entitys
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
