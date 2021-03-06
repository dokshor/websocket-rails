require "active_support/dependencies"
require 'thin'

module WebsocketRails
  mattr_accessor :app_root
  
  def self.setup
    yield self
  end
  
  def self.route_block=(routes)
    @event_routes = routes
  end
  
  def self.route_block
    @event_routes
  end
end

LOG_LEVEL = :warn

require 'websocket_rails/engine'
require 'websocket_rails/logging'
require 'websocket_rails/connection_manager'
require 'websocket_rails/dispatcher'
require 'websocket_rails/event'
require 'websocket_rails/event_map'
require 'websocket_rails/event_queue'
require 'websocket_rails/channel'
require 'websocket_rails/channel_manager'
require 'websocket_rails/base_controller'
require 'websocket_rails/internal_events'

require 'websocket_rails/connection_adapters'
require 'websocket_rails/connection_adapters/http'
require 'websocket_rails/connection_adapters/web_socket'

# Exceptions
class InvalidConnectionError < StandardError
  def rack_response
    [400,{'Content-Type' => 'text/plain'},['invalid connection']]
  end
end

# Deprecation Notices
class WebsocketRails::Dispatcher
  def self.describe_events(&block)
    raise "This method has been deprecated. Please use WebsocketRails::EventMap.describe instead."
  end
end
class WebsocketRails::Events
  def self.describe_events(&block)
    raise "This method has been deprecated. Please use WebsocketRails::EventMap.describe instead."
  end
end
