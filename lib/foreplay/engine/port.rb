module Foreplay::Engine::Port
  include Foreplay

  def host
    return @host if @host
    @host, _p = server.split(':') # Parse host + port
    @host
  end

  def name
    @name ||= instructions['name']
  end

  def current_port
    @current_port ||= port_details['current_port']
  end

  def current_service
    @current_service ||= port_details['current_service']
  end

  def former_port
    @former_port ||= port_details['former_port']
  end

  def former_service
    @former_service ||= port_details['former_service']
  end

  def current_port_file
    @current_port_file ||= ".foreplay/#{name}/current_port"
  end

  def port_steps
    @port_steps ||= [
      {
        'command' => "mkdir -p .foreplay/#{name} && touch #{current_port_file} && cat #{current_port_file}",
        'silent' => true
      }
    ]
  end

  def current_port_string
    return @current_port_string if @current_port_string

    @current_port_string = Foreplay::Engine::Remote
                           .new(server, port_steps, instructions)
                           .__send__(mode)
                           .strip!
                           .to_i

    message = if @current_port_string.blank?
                'No instance is currently deployed'
              else
                "Current instance is using port #{@current_port_string}"
              end

    log message, host: host
  end

  def port_details
    return @port_details if @port_details

    cp      = current_port_string
    port    = instructions['port']
    ports   = [port + 1000, port]
    cp, fp  = cp == port ? ports : ports.reverse

    @port_details = {
      'current_port'    => cp,
      'current_service' => "#{name}-#{cp}",
      'former_port'     => fp,
      'former_service'  => "#{name}-#{fp}"
    }
  end
end
