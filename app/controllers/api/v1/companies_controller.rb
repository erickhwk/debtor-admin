class Api::V1::CompaniesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:lawsuit_id].present?
      @companies = Company.joins(:lawsuits).where(lawsuits: {id: params[:lawsuit_id]}).reverse
      render json: @companies
    else
      render json: { error: 'Lawsuit ID is required' }, status: :unprocessable_entity
    end
  end
end
