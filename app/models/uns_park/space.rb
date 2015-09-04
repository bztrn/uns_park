require 'uns_core/has_permissions'


module UnsPark
  class Space < ActiveRecord::Base
    include UnsCore::HasPermissions
    belongs_to :user

    has_many :subscribers, :class_name => 'UnsPark::Subscriber'
    accepts_nested_attributes_for :subscribers, :allow_destroy => true

    has_attached_file :fav_icon, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :fav_icon, :content_type =>  /\Aimage\/.*\Z/

    has_attached_file :main_icon, :default_url => "/images/:style/missing.png", :styles => { :medium => "300x300>", :thumb => "100x100>" }
    validates_attachment_content_type :main_icon, :content_type =>  /\Aimage\/.*\Z/

    searchable do
      text :name, :as => :name_textp
      text :tagline, :as => :tagline_textp
      text :footer, :as => :footer_textp
      text :domain
      integer :security do
        self[:security]
      end
      integer :user_id
    end
    
    def searchable_thumbnail
      'uns_park/spaces/search_result'
    end

  
  end
end
