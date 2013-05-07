require 'singleton'
#
# Simple logger class for the whole application
#
module Tapir
class TapirLogger

  include Singleton

  def initialize
    @out = File.open(File.join(Rails.root,"log","tapir.log"), "a")
  end

  def log(message)
    _log "[_] Tapir: " << message  
  end

  ######
  def log_debug(message) 
    _log "[D] Tapir: " << message
  end

  def log_good(message)
    _log "[+] Tapir: " << message
  end

  def log_error(message)
    _log "[-] Tapir: " << message
  end
  ######

private 
  def _log(message) 
   @out.puts message
   @out.flush
  end

end
end