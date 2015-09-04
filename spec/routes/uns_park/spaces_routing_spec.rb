require "rails_helper"

module UnsPark
  RSpec.describe SpacesController, type: :routing do
    routes { UnsPark::Engine.routes }

    describe "routing" do
      it "routes to #index" do
        expect(:get => "/spaces").to route_to("uns_park/spaces#index")
      end

      it "routes to #show" do
        expect(:get => "/spaces/1").to route_to("uns_park/spaces#show", "id"=>"1")
      end

      it "routes to #create" do
        expect(:post => "/spaces").to route_to("uns_park/spaces#create")
      end

      it "routes to #destroy" do
        expect(:delete => "/spaces/1").to route_to("uns_park/spaces#destroy", :id => "1")
      end

      it "routes to #own" do
        expect(:get => "/spaces/1/own").to route_to("uns_park/spaces#own", :id => "1")
      end

      it "routes to #spot" do
        expect(:get => "/spaces/spot").to route_to("uns_park/spaces#spot")
      end
    end
  end
end
