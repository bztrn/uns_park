include MigrationHelper
require 'paperclip'

class CreateUnsParkSpaces < ActiveRecord::Migration
  def change
    create_table :uns_park_spaces do |t|
      t.has_permissions
      t.goes_in_cases

      t.string :name
      t.string :domain
      t.string :background_color, :default => '#ffffff'

      t.text :tagline
      t.boolean :footer
      t.boolean :subscribe
      t.boolean :ad_hoc, :default => false

      t.integer :count

      t.attachment :fav_icon
      t.attachment :main_icon

      t.timestamps null: false
    end

    create_table :uns_park_subscribers do |t|
      t.string :email
      t.references :space
      t.timestamps null: false
    end
  end
end
