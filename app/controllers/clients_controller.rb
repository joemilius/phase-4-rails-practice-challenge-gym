class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    wrap_parameters format: []
    
    def index
        clients = Client.all
        render json: clients, status: :ok
    end

    def show
        client = Client.find(params[:id])
        render json: client, methods: [:total_charges]
    end

    def update
        client = Client.find(params[:id])
        if client.update(client_params)
            render json: client, status: :ok
        else 
            render json: {errors: client.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def client_params
        params.permit(:name, :age)
    end

    def not_found_response
        render json: {error: "Gym not found"}, status: :not_found
    end
end
