module Nextcloud
  module Ruby
    class Tag
      ALL_XML = '<?xml version="1.0"?>
        <d:propfind
        xmlns:d="DAV:"
        xmlns:oc="http://owncloud.org/ns"
        xmlns:nc="http://nextcloud.org/ns">
          <d:prop>
            <oc:display-name />
            <oc:id />
          </d:prop>
        </d:propfind>'.freeze

      class << self
        def find(id)
          uri = Addressable::URI
                .parse("systemtags/#{id}")
          response = Api.request(:propfind, uri, ALL_XML)
          response.ok? ? parse_tag(response.body.xpath('//d:prop')) : nil
        end

        def all
          response = Api.request(:propfind, 'systemtags', ALL_XML)
          response.ok? ? parse_all(response) : nil
        end

        private

        def parse_tag(response)
          id = response.xpath('./oc:id').text.to_i
          name = response.xpath('./oc:display-name').text
          Nextcloud::Ruby::Models::Tag.new(id, name) unless id.zero?
        end

        def parse_all(response)
          [].tap do |tags|
            response.body.xpath('//d:prop').each do |prop|
              tags << parse_tag(prop) unless parse_tag(prop).nil?
            end
          end
        end
      end
    end
  end
end
