class LawsuitsController < ApplicationController
  before_action :set_lawsuit, only: %i[ show edit update destroy ]

  # GET /lawsuits or /lawsuits.json
  def index
    return @lawsuits = Lawsuit.all.reverse  if current_user.profile.role == 'developer'
    @lawsuits = Lawsuit.where(tenancy: current_user.profile.tenancy).reverse
  end

  # GET /lawsuits/1 or /lawsuits/1.json
  def show
  end

  # GET /lawsuits/new
  def new
    @lawsuit = Lawsuit.new
    @tenancies = Tenancy.all
  end

  # GET /lawsuits/1/edit
  def edit
    @tenancies = Tenancy.all
  end

  # POST /lawsuits or /lawsuits.json
  def create
    @lawsuit = Lawsuit.new(lawsuit_params)
    @lawsuit.tenancy = current_user.profile.tenancy if params[:lawsuit][:tenancy_id].blank?
    @lawsuit.created_by = current_user

    respond_to do |format|
      if @lawsuit.save
        format.html { redirect_to lawsuits_url, notice: "Lawsuit was successfully created." }
        format.json { render :show, status: :created, location: @lawsuit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lawsuit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lawsuits/1 or /lawsuits/1.json
  def update
    respond_to do |format|
      if @lawsuit.update(lawsuit_params)
        format.html { redirect_to lawsuits_url, notice: "Lawsuit was successfully updated." }
        format.json { render :show, status: :ok, location: @lawsuit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lawsuit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lawsuits/1 or /lawsuits/1.json
  def destroy
    @lawsuit.destroy!

    respond_to do |format|
      format.html { redirect_to lawsuits_url, notice: "Lawsuit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lawsuit
      @lawsuit = Lawsuit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lawsuit_params
      params.require(:lawsuit).permit(:alias, :category, :created_by_id, :tenancy_id)
    end
end
