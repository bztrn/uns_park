require_dependency "application_controller"

module UnsPark
  class SubscribersController < UnsCore::ApplicationController
    before_action :set_subscriber, only: [:destroy]

    def create
      @space = UnsPark::Space.find(params[:space_id])
      known_subscriber = @space.subscribers.find_by_email(subscribers_params[:email])

      unless known_subscriber.nil?
        redirect_to uns_park.root_url(:dmn => @space.domain), notice: 'Thanks! We already have you!.'
      else
        @subscriber = @space.subscribers.create(subscribers_params)

        if @subscriber.save
          redirect_to uns_park.root_url(:dmn => @space.domain), notice: 'Thanks! We will let you know!.'
        else
          redirect_to uns_park.root_url(:dmn => @space.domain), notice: "Sorry. That doesn't seem like an email address"
        end
      end
    end

    def destroy
      @subscriber.destroy
      redirect_to @space, notice: 'Space was successfully updated.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_subscriber
        @space = current_user.spaces.find(params[:space_id])
        @subscriber = @space.subscribers.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def subscribers_params
        params.require(:subscriber).permit(:email)
      end
  end
end
