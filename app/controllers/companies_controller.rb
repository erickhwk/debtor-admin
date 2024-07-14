class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]
  before_action :set_lawsuits, only: %i[new edit]
  before_action :check_if_theres_lawsuits, only: %i[new create]

  # GET /companies or /companies.json
  def index
    return @companies = Company.all.reverse if current_user.profile.role == 'developer'
    @companies = Company.joins(:lawsuits).where(lawsuits: {tenancy: current_user.profile.tenancy}).reverse
  end

  # GET /companies/1 or /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)
    @company.created_by_id = current_user.id

    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_url, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to companies_url, notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy!

    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def check_if_theres_lawsuits
      unless current_user.profile.role == 'developer'
        redirect_to new_lawsuit_path, alert: 'Não existem processos para associar a uma empresa. Por favor, crie sua primeira empresa.' if Lawsuit.where(tenancy: current_user.profile.tenancy).empty?
      end
    end

    def set_lawsuits
      current_user.profile.role == 'developer' ?
        @lawsuits = Lawsuit.all :
        @lawsuits = Lawsuit.where(tenancy: current_user.profile.tenancy)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :cnpj, :created_by, lawsuit_ids: [])
    end
end
