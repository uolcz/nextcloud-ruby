module Nextcloud
  module Ruby
    module Models
      class Tag
        attr_reader :id, :name

        def initialize(id, name)
          @id = id
          @name = name
        end
      end
    end
  end
end
