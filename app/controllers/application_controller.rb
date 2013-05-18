class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_tenant

  def set_current_tenant

    # Grab the current host
    current_tenant = Tapir::Tenant.where(:host => request.host).first

    # Create a tenant record for this host if none exists. 
    current_tenant = Tapir::Tenant.create(:host => request.host) unless current_tenant

    # Set the current tenant
    Mongoid::Multitenancy.current_tenant = current_tenant

  end

end
