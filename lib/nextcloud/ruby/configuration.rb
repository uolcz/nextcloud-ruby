##
#
# This is configuration class that allows you to set your config like so:
#
# Nextcloud::Ruby.configure do |config|
#   config.dav_url     = 'https://mydav.com/x.php'
#   config.username    = 'jon'
#   config.password    = 'SuperSecret'
#   config.directories = [
#     'root/folder/name',
#     'any/other/folder/name',
#     'some/more'
#   ]
# end
#
# or
#
# by simply assigning params by themself:
#
# config = Nextcloud::Ruby::Configuration.new
# config.dav_url     = 'https://mydav.com/x.php'
# config.username    = 'jon'
# config.password    = 'SuperSecret'
# config.directories = [
#   'root/folder/name',
#   'any/other/folder/name',
#   'some/more'
# ]
# Nextcloud::Ruby.configuration = config
#
module Nextcloud
  module Ruby
    class Configuration
      attr_writer :dav_url, :username, :password, :directories

      def initialize
        @dav_url = nil
        @username = nil
        @password = nil
        @directories = nil
      end

      def dav_url
        raise Errors::ConfigNotSet, 'dav_url' unless @dav_url
        URI(@dav_url)
      end

      def username
        raise Errors::ConfigNotSet, 'username' unless @username
        @username
      end

      def password
        raise Errors::ConfigNotSet, 'password' unless @password
        @password
      end

      def directories
        raise Errors::ConfigNotSet, 'directories' unless @directories
        @directories
      end
    end
  end
end
