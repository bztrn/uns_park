Rails.application.routes.default_url_options[:host] = 'unsil.io'

Rails.application.routes.draw do

  mount UnsPark::Engine => "/uns_park"
end
