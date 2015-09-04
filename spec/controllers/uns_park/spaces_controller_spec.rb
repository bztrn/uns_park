require 'rails_helper'
require 'user'

module UnsPark
  RSpec.describe SpacesController, type: :controller do
    routes { UnsPark::Engine.routes }
    let(:test_domain) { 'testdomain.com' }
    let(:test_domain_2) { 'www.testdomain.com' }
    let(:valid_attributes) do
      {
        :space => {
          :name => 'test name',
          :domain => test_domain,
        },  
      }
    end

    let(:new_attributes) do
      {
        :id => test_space.to_param,
        :space => {
          :name => 'my new test name',
          :domain => test_domain,
        },  
      }
    end

    let(:test_user) { User.create!(:email => 'a@b.com', :password => 'asdasdasd', :password_confirmation => 'asdasdasd') }
    let(:test_space) { test_user.spaces.create(valid_attributes[:space]) }
    let(:ad_hoc_space) { UnsPark::Space.create(valid_attributes[:space].merge(:ad_hoc => true)) }
    let(:valid_session) { Hash.new }

    before(:each) do
      sign_in(test_user)
    end

    describe "GET #index" do
      it "assigns all spaces as @spaces" do
        qs = test_space
        ahs = ad_hoc_space
        get 'index', {}, valid_session
        expect(assigns(:spaces)).to eq([qs])
      end

      it "assigns all ad-hoc spaces as @ad_hoc_spaces" do
        qs = test_space
        ahs = ad_hoc_space
        get 'index', {}, valid_session
        expect(assigns(:ad_hoc_spaces)).to eq([ahs])
      end
    end

    describe "GET #show" do
      it "assigns the spaces as @space" do
        get 'show', {:id => test_space.to_param}, valid_session
        expect(assigns(:space)).to eq(test_space)
      end
    end

    describe "GET #edit" do
      it "assigns the spaces as @space" do
        get 'edit', {:id => test_space.to_param}, valid_session
        expect(assigns(:space)).to eq(test_space)
      end
    end

    describe "POST #create" do
      context "when successful" do
        it "creates a new Space" do
          expect {
            post :create, valid_attributes, valid_session
          }.to change(UnsPark::Space, :count).by(1)
        end

        it "assigns a newly created space as @space" do
          post :create, valid_attributes, valid_session
          expect(assigns(:space)).to be_a(UnsPark::Space)
          expect(assigns(:space)).to be_persisted
        end
      end
    end

    describe "PUT #update" do
      context "when successful" do
        it "changes the space" do
          patch :update, new_attributes, valid_session
          test_ans = UnsPark::Space.find(test_space.to_param)
          expect(test_ans.name).to eq('my new test name')
        end

        it "assigns a newly created space as @space" do
          post :create, valid_attributes, valid_session
          expect(assigns(:space)).to be_a(UnsPark::Space)
          expect(assigns(:space)).to be_persisted
        end
      end
    end

    describe "DELETE #destroy" do

      it "destroys the requested feed" do
        test_space
        expect {
          delete :destroy, {:id => test_space.to_param}, valid_session
        }.to change(Space, :count).by(-1)
      end

      it "redirects to the feeds list" do
        delete :destroy, {:id => test_space.to_param}, valid_session
        expect(response).to redirect_to(spaces_path)
      end
    end

    describe 'GET #own' do
      it 'changes the ownership of an ad hoc item' do
        expect {
          get :own, {:id => ad_hoc_space.to_param}, valid_session
        }.to change(test_user.spaces, :count).by(1)
      end

      it 'changes the ownership of an ad hoc item' do
        get :own, {:id => ad_hoc_space.to_param}, valid_session
        test_ans = UnsPark::Space.find(ad_hoc_space.to_param)
        expect(test_ans.ad_hoc).to be false
      end

      it "redirects to the feeds list" do
        get :own, {:id => ad_hoc_space.to_param}, valid_session
        expect(response).to redirect_to(spaces_path)
      end
    end

    describe 'GET #spot' do
      context 'requests a space that exists' do
        it 'increments the count' do
          test_space
          get :spot, {:dmn => test_space.domain}, valid_session
          get :spot, {:dmn => test_space.domain}, valid_session
          get :spot, {:dmn => test_space.domain}, valid_session
          test_ans = UnsPark::Space.find(test_space.to_param)
          expect(test_ans.count).to eq 3
        end

        it 'ignores the subdomain' do
          test_space
          get :spot, {:dmn => test_domain_2}, valid_session
          test_ans = UnsPark::Space.find(test_space.to_param)
          expect(test_ans.count).to eq 1
        end

        it 'assign test_user the requested space to @space' do
          get :spot, {:dmn => test_domain}, valid_session
          expect(assigns(:space)).to be_a(UnsPark::Space)
        end
      end

      context 'requests a space that doesnt exist' do
        it 'creates an ad-hoc space' do
          expect {
            get :spot, {:dmn => 'unknown.com'}, valid_session
          }.to change(Space, :count).by(1)
        end

        it 'sets the count on the space to 1' do
          get :spot, {:dmn => 'unknown.com'}, valid_session
          test_ans = UnsPark::Space.find_by_domain('unknown.com')
          expect(test_ans.count).to eq 1
        end
      end
    end
  end
end
