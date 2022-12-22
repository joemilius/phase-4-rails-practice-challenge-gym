class GymsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    wrap_parameters format: []
    
    def index
        gyms = Gym.all
        render json: gyms, status: :ok
    end

    def show
        gym = Gym.find(params[:id])
        render json: gym, status: :ok
    end

    def update
        gym = Gym.find(params[:id])
        if gym.update(gym_params)
            render json: gym, status: :ok
        else 
            render json: {errors: gym.errors.full_messages}, status: :unprocessable_entity
        end
    end


    def destroy
        gym = Gym.find(params[:id])
        gym.destroy
        head :no_content
    end

    private

    def gym_params
        params.permit(:name, :address)
    end

    def not_found_response
        render json: {error: "Gym not found"}, status: :not_found
    end
end
