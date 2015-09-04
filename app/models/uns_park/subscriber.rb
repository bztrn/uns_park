require 'validates_email_format_of'

module UnsPark
  class Subscriber < ActiveRecord::Base
    validates_presence_of :email
    validates :email, email_format: { message: "doesn't look like an email address" }
  end
end