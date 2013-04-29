module EntitiesHelper

  def tapir_entities_path(id=nil)
    "/tapir/entities/#{id}"
  end

  ### TODO - There's probably a better way to do this
  ### even if it means using method_missing
  def tapir_entities_domain_path(id=nil, whatever=nil)
    "/tapir/entities/#{id}"  
  end

  def tapir_entities_host_path(id=nil, whatever=nil)
    "/tapir/entities/#{id}"  
  end

  def tapir_entities_account_path(id=nil, whatever=nil)
    "/tapir/entities/#{id}"  
  end

  def tapir_entities_finding_path(id=nil, whatever=nil)
    "/tapir/entities/#{id}"  
  end

  def tapir_entities_net_svc_path(id=nil, whatever=nil)
    "/tapir/entities/#{id}"  
  end

  def tapir_entities_organization_path(id=nil, whatever=nil)
    "/tapir/entities/#{id}"  
  end
  
end
