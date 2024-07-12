class Api::V1::CompaniesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:tenancy_id].present?
      @companies = Company.joins(:lawsuits).where(lawsuits: {tenancy_id: params[:tenancy_id] }).reverse
      render json: @companies
    else
      render json: { error: 'Tenancy ID is required' }, status: :unprocessable_entity
    end
  end
end
