module Nextcloud
  module Ruby
    class Response
      SUCCESS_CODES = [201, 204, 207].freeze
      attr_accessor :body, :status_code

      def initialize(body, status_code)
        @body = to_xml(body)
        @status_code = status_code
      end

      def ok?
        SUCCESS_CODES.include?(@status_code)
      end

      private

      def to_xml(body)
        Nokogiri::XML.parse(body)
      end
    end
  end
end
