require "rails_helper"

module UnsPark
  RSpec.describe SubscribersController, type: :routing do
    routes { UnsPark::Engine.routes }

    describe "routing" do
      it "routes to #create" do
        expect(:post => "/subscribers").to route_to("uns_park/subscribers#create")
      end

      it "routes to #destroy" do
        expect(:delete => "/subscribers/1").to route_to("uns_park/subscribers#destroy", :id => "1")
      end
    end
  end
end
