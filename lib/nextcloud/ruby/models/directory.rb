module Nextcloud
  module Ruby
    module Models
      class Directory
        attr_reader :id, :path

        def initialize(id, path)
          @id = id
          @path = path
        end
      end
    end
  end
end
