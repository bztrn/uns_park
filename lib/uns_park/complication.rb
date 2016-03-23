require 'uns_core/complication_base'

module UnsPark
  class Complication < UnsCore::ComplicationBase
  
    def initialize
    end

    def user_bindings
      {
        :spaces => {:many => true, :class_name => 'UnsPark::Space'}
      }
    end

    def searchable
      [
        UnsPark::Space,
      ]
    end

    def front_page_links
      [
        {
          :uid => :uns_park_park,
          :default => true,
          :label => 'domains',
          :image => 'uns_park/space_link.png',
          :url => UnsPark::Engine.routes.url_helpers.spaces_path,
        },
      ]
    end

    def themes
      []
    end

  end
end