module Nextcloud
  module Ruby
    class Directory
      FIND_XML = '<?xml version="1.0"?>
        <d:propfind
          xmlns:d="DAV:"
          xmlns:oc="http://owncloud.org/ns"
          xmlns:nc="http://nextcloud.org/ns">
          <d:prop>
            <oc:fileid />
          </d:prop>
        </d:propfind>'.freeze

      class << self
        def create(path)
          uri = Addressable::URI
                .parse("files/#{Nextcloud::Ruby.configuration.username}/#{path}")
          Api.request(:mkcol, uri)
        end

        def delete(path)
          uri = Addressable::URI
                .parse("files/#{Nextcloud::Ruby.configuration.username}/#{path}")
          Api.request(:delete, uri)
        end

        def find(path)
          uri = Addressable::URI
                .parse("files/#{Nextcloud::Ruby.configuration.username}/#{path}")
          response = Api.request(:propfind, uri, FIND_XML)
          response.ok? ? parse_directory(response, path) : nil
        end

        def set_tag(directory, tag)
          return Response.new('', 400) unless directory && tag
          uri = Addressable::URI
                .join(Nextcloud::Ruby.configuration.dav_url.path.to_s,
                      "systemtags-relations/files/#{directory.id}/#{tag.id}")
          Api.request(:put, uri)
        end

        private

        def parse_directory(response, path)
          id = response.body.xpath('//oc:fileid')[0].text.to_i
          Nextcloud::Ruby::Models::Directory.new(id, path)
        end
      end
    end
  end
end
