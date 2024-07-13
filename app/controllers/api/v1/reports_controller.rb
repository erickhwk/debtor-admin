class Api::V1::ReportsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:lawsuit_id].present?
      @reports = Report.where(lawsuit_id: params[:lawsuit_id] ).reverse
      render json: @reports, each_serializer: ReportSerializer
    else
      render json: { error: 'Lawsuit ID is required' }, status: :unprocessable_entity
    end
  end
end
