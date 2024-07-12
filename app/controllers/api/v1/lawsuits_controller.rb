class Api::V1::LawsuitsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:tenancy_id].present?
      @lawsuits = Lawsuit.where(tenancy_id: params[:tenancy_id])
      render json: @lawsuits
    else
      render json: { error: 'Tenancy ID is required' }, status: :unprocessable_entity
    end
  end
end
