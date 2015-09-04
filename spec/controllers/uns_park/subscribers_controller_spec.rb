require 'rails_helper'
require 'user'

module UnsPark
  RSpec.describe SubscribersController, type: :controller do
    routes { UnsPark::Engine.routes }
    let(:valid_attributes) do
      {
        :space_id => test_space.to_param,
        :subscriber => {
          :email => 'example@example.com',
        },  
      }
    end
    let(:space_attributes) do
      {
        :space => {
          :name => 'test name',
          :domain => 'http://test-domain.com',
        },  
      }
    end

    let(:test_space) { UnsPark::Space.create(space_attributes[:space]) }
    let(:test_sub) { UnsPark::Subscriber.create(:email => 'test@test.com') }
    let(:valid_session) { Hash.new }

    describe "POST #create" do
      context "when successful" do

        it "creates a new subscriber" do
          expect {
            post :create, valid_attributes, valid_session
          }.to change(UnsPark::Subscriber, :count).by(1)
        end

        it "assigns a newly created space as @subscriber" do
          post :create, valid_attributes, valid_session
          expect(assigns(:subscriber)).to be_a(UnsPark::Subscriber)
          expect(assigns(:subscriber)).to be_persisted
        end
      end
    end

    describe "DELETE #destroy" do
      before(:each) do
        sign_in(test_user)
      end
      let(:test_user) { User.create!(:email => 'a@b.com', :password => 'asdasdasd', :password_confirmation => 'asdasdasd') }
      let(:users_test_space) { test_user.spaces.create(space_attributes[:space]) }
      let(:users_test_sub) { users_test_space.subscribers.create(:email => 'example@example.com') }

      it "destroys the requested feed" do
        users_test_sub
        expect {
          delete :destroy, {:id => users_test_sub.to_param, :space_id => users_test_space.to_param}, valid_session
        }.to change(Subscriber, :count).by(-1)
      end

      it "redirects to the feeds list" do
        delete :destroy, {:id => users_test_sub.to_param, :space_id => users_test_space.to_param}, valid_session
        expect(response).to redirect_to(space_path(users_test_space))
      end
    end

  end
end
