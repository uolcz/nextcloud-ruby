module Nextcloud
  module Ruby
    class Api
      def initialize(method, path, payload = nil)
        @method = method
        @payload = payload
        @path = Addressable::URI
                .join(Nextcloud::Ruby.configuration.dav_url.to_s, path)
        @uri = Nextcloud::Ruby.configuration.dav_url
        @username = Nextcloud::Ruby.configuration.username
        @password = Nextcloud::Ruby.configuration.password
        init_request
      end

      def self.request(method, path, payload = nil)
        new(method, path, payload).request
      end

      def request
        response = Net::HTTP.start(@uri.host, @uri.port,
                                   use_ssl: @uri.scheme == 'https') do |http|
          http.request(@request)
        end
        Response.new(response.body, response.code.to_i)
      end

      private

      def init_request
        @request = net_http_class.new(@path)
        @request.body = @payload if @payload
        @request.basic_auth @username, @password
      end

      def net_http_class
        Kernel.const_get("Net::HTTP::#{@method.capitalize}")
      end
    end
  end
end
