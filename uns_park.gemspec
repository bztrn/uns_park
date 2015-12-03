$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "uns_park/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "uns_park"
  s.version     = UnsPark::VERSION
  s.authors     = ["Steven Fuchs"]
  s.email       = ["stwf@mac.com"]
  s.homepage    = "http://unsilo.io"
  s.summary     = "Summary of UnsPark."
  s.description = "Description of UnsPark."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "validates_email_format_of"
  s.add_dependency "public_suffix"
end
