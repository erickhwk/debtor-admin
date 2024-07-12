class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]
  before_action :set_lawsuits, only: %i[new edit]
  before_action :check_if_theres_lawsuits, only: %i[new create]


  # GET /reports or /reports.json
  def index
    return @reports = Report.all.reverse  if current_user.profile.role == 'developer'
    @reports = Report.joins(:lawsuit).where(lawsuits: { tenancy_id: current_user.profile.tenancy_id }).reverse
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)
    @report.created_by = current_user

    respond_to do |format|
      if @report.save
        format.html { redirect_to reports_url, notice: "Report was successfully created." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to reports_url, notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy!

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def remove_file
    report = Report.find(params[:id])
    report.files.find(params[:file]).purge

    redirect_to report_path(report), notice: 'File was successfully removed.'
  end

  def remove_all_files
    report = Report.find(params[:id])
    report.files.purge

    redirect_to reports_path, notice: 'All attachments were successfully removed.'
  end

  private
    def check_if_theres_lawsuits
      unless current_user.profile.role == 'developer'
        redirect_to new_lawsuit_path, alert: 'Não existem processos para associar a um informe. Por favor, crie seu primeiro processo.' if Lawsuit.where(tenancy: current_user.tenancy).empty?
      end
    end

    def set_lawsuits
      current_user.profile.role == 'developer' ?
        @lawsuits = Lawsuit.all :
        @lawsuits = Lawsuit.where(tenancy: current_user.tenancy)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :lawsuit_id, :content, files: [] )
    end
end
