class MembershipsController < ApplicationController
wrap_parameters format: []
    def create
        membership = Membership.create(membership_params)
        if membership.valid?
            render json: membership, status: :created
        else
            render json: {errors: membership.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def membership_params
        params.permit(:charge, :gym_id, :client_id)
    end
end
