class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_client

  def set_current_client
    current_tenant = Tapir::Tenant.where(:host => request.host).first
    Mongoid::Multitenancy.current_tenant = current_tenant
  end

end
