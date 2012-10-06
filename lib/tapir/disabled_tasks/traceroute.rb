#
# Simple Traceroute
#
# Many thanks to tmarciniak for the rubyroute code
# http://code.google.com/p/rubyroute/
#

require 'timeout'
require 'socket'

  extend Socket::Constants

def name
  "traceroute"
end

def description
  "Simple Traceroute"
end

def allowed_types
  [Tapir::Entities::Host]
end

def setup(entity, options={})
  super(entity, options)
end

def run
  super
  
  begin
    myname = Socket.gethostname 
  rescue SocketError => err_msg
    @task_logger.log_error "Couldn't get hostname: #{err_msg}"
    return
  end

  @task_logger.log "Using name: #{myname}"
  @task_logger.log "Tracing route to #{@entity.ip_address}"

  start_ttl     = @options[:start_ttl] || 1
  max_ttl       = @options[:max_ttl] || 35
  localport     = random_port
  dgram_sock    = UDPSocket::new
  
  @task_logger.log "Using port: #{localport}"
  
  #
  # Set up a listener socket
  #
  #begin
  #  dgram_sock.bind( myname, localport )
  #rescue 
  #  localport = random_port
  #  retry
  #end

  #
  # Set up the icmp listener 
  #
  @task_logger.log "Binding ICMP Listener"
  icmp_sock     = Socket.open( Socket::PF_INET, Socket::SOCK_RAW, Socket::IPPROTO_ICMP )
  icmp_sockaddr = Socket.pack_sockaddr_in( localport, myname )
  icmp_sock.bind icmp_sockaddr
  
  #
  # Connect to remote host
  #
  begin
    dgram_sock.connect @entity.ip_address, 999
  rescue SocketError => err_msg
    @task_logger.log "Can't connect to remote host (#{err_msg})."
    return
  end

  @task_logger.log "Using name: #{myname}"
  @task_logger.log "Beginning traceroute..."
  ttl = start_ttl
  until ttl == max_ttl
    dgram_sock.setsockopt( 0, Socket::IP_TTL, ttl )
    dgram_sock.send( "Tapir says hello!", 0 )

    begin
      Timeout::timeout( 5 ) do
        data, sender = icmp_sock.recvfrom( 8192 )

        # 20th and 21th bytes of IP+ICMP datagram carry 
        # the ICMP type and code resp.
        icmp_type = data.unpack( '@20C' )[0]
        icmp_code = data.unpack( '@21C' )[0]
        
        # Extract the ICMP sender from response.
        @task_logger.log "TTL = #{ttl}:  " + Socket.unpack_sockaddr_in( sender )[1].to_s
        
        if icmp_type == 3 and icmp_code == 13
          @task_logger.log "'Communication Administratively Prohibited' from this hop."
        
        # ICMP 3/3 is port unreachable and usually means that we've hit the target.
        elsif icmp_type == 3 and icmp_code == 3
          @task_logger.log "Destination reached. Trace complete."
          exit 0
        end
      end

    rescue Timeout::Error
      @task_logger.log "Timeout error with TTL = #{ttl}!"
    end

  ttl += 1
  end
end

def random_port
  1024 + rand(64511)
end

def cleanup
  super
end
