class Api::V1::ReportsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:tenancy_id].present?
      @reports = Report.joins(:lawsuit).where(lawsuits: { tenancy_id: params[:tenancy_id] }).reverse
      render json: @reports, each_serializer: ReportSerializer
    else
      render json: { error: 'Tenancy ID is required' }, status: :unprocessable_entity
    end
  end
end
