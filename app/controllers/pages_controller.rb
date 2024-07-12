class PagesController < ApplicationController
  def index
    unless current_user.profile.role == 'developer'
      @reports = Report.joins(:lawsuit).where(lawsuits: { tenancy_id: current_user.profile.tenancy_id }).latest
      @lawsuits = Lawsuit.where(tenancy_id: current_user.profile.tenancy_id).latest
      @companies = Company.joins(:lawsuits).where(lawsuits: { tenancy_id: current_user.profile.tenancy_id }).latest
    else
      @reports = Report.all.latest
      @lawsuits = Lawsuit.all.latest
      @companies = Company.all.latest
    end
  end
end
