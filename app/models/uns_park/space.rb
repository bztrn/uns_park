require 'uns_core/has_permissions'


module UnsPark
  class Space < ActiveRecord::Base
    include UnsCore::HasCases
    include UnsCore::HasPermissions
    include UnsCore::IsSearchable

    belongs_to :user

    searchable_terms([:tagline, :tagline, :domain])
    searchable_date(:created_at)

    has_many :subscribers, :class_name => 'UnsPark::Subscriber'
    accepts_nested_attributes_for :subscribers, :allow_destroy => true

    has_attached_file :fav_icon, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :fav_icon, :content_type =>  /\Aimage\/.*\Z/

    has_attached_file :main_icon, :default_url => "/images/:style/missing.png", :styles => { :medium => "300x300>", :thumb => "100x100>" }
    validates_attachment_content_type :main_icon, :content_type =>  /\Aimage\/.*\Z/

  end
end
