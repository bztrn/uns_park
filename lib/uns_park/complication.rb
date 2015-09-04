
module UnsPark
  class Complication
  
    def user_bindings
      {
        :spaces => 'UnsPark::Space'
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