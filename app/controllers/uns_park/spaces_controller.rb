require_dependency "application_controller"
require 'public_suffix'

module UnsPark
  class SpacesController < UnsCore::ApplicationController
    before_action :set_space, only: [:show, :edit, :update, :destroy]

    def index
      @spaces = content_user.spaces_for(current_user).where(:ad_hoc => false)
      @ad_hoc_spaces = UnsPark::Space.where(:ad_hoc => true)
    end

    def show
    end

    def edit
    end

    def create
      @space = current_user.spaces.create(space_params)

      if @space.save
        redirect_to spaces_path
      else
        render :new
      end
    end

    def update
      if @space.update(space_params)
        redirect_to @space, notice: 'Space was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @space.destroy
      redirect_to spaces_url
    end

    def own
      @space = UnsPark::Space.find(params[:id])
      if @space.ad_hoc?
        @space.user = current_user
        @space.ad_hoc = false
        @space.save
      end
      redirect_to spaces_path
    end

    def spot
      @domain = request.env['SERVER_NAME']
      @domain = params[:dmn] if params.has_key?(:dmn)
      ps = PublicSuffix.parse(@domain)
      @domain = ps.domain

      @space = UnsPark::Space.find_by_domain(@domain)
      if @space.nil?
        @space = UnsPark::Space.create({
          :name => @domain,
          :domain => @domain,
          :security => :vip_only,
          :count => 1,
          :ad_hoc => true,
        })
      else
        UnsPark::Space.increment_counter(:count, @space.id)
      end
      render :layout => false
    end

    private

    def set_space
      @space = content_user.spaces_for(current_user).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def space_params
      params.require(:space).permit(:name, :security, :domain, :tagline, :background_color, :footer, :fav_icon, :main_icon, :subscribe)
    end
  end
end
