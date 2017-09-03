##
# External dependencies
#
require 'net/https'
require 'nokogiri'
require 'addressable'

##
# Classes from this gem
#
require 'nextcloud/ruby/version'
require 'nextcloud/ruby/utils/errors'

require 'nextcloud/ruby/configuration'
require 'nextcloud/ruby/api'
require 'nextcloud/ruby/response'
require 'nextcloud/ruby/directory'
require 'nextcloud/ruby/tag'

require 'nextcloud/ruby/models/directory'
require 'nextcloud/ruby/models/tag'

##
#
# Main module of Nextcloud API wrapper
#
# See 'nextcloud/ruby/configuration.rb' for more explanation how to set configuration
#
module Nextcloud
  module Ruby
    class << self
      attr_accessor :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
