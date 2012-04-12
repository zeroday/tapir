  #module EAR

class Object


  #
  # TODO - this is used to find candidates for a task - this will need optimization
  #  or a better approach sooner rather than later
  #
  def all
    objects = []
    Domain.all.each {|x| objects << x } unless Domain.all == [] 
    Finding.all.each {|x| objects << x }  unless Finding.all == []  
    Host.all.each {|x| objects << x }  unless Host.all == [] 
    NetBlock.all.each {|x| objects << x }  unless NetBlock.all == [] 
    NetSvc.all.each {|x| objects << x }  unless NetSvc.all == []
    Organization.all.each {|x| objects << x }  unless Organization.all == []
    PhysicalLocation.all.each {|x| objects << x }   unless PhysicalLocation.all == []
    SearchString.all.each {|x| objects << x }  unless SearchString.all == []
    User.all.each {|x| objects << x }  unless User.all == []
    WebApp.all.each {|x| objects << x }  unless WebApp.all == []
    WebForm.all.each {|x| objects << x }  unless WebForm.all == []
    Image.all.each {|x| objects << x }  unless Image.all == []
    Account.all.each {|x| objects << x }  unless Account.all == []
    ParsableFile.all.each {|x| objects << x }  unless ParsableFile.all == []
    
  objects
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
