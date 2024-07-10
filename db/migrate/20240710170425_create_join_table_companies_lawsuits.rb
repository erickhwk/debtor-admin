class CreateJoinTableCompaniesLawsuits < ActiveRecord::Migration[7.1]
  def change
    create_join_table :companies, :lawsuits do |t|
      t.index [:company_id, :lawsuit_id]
      t.index [:lawsuit_id, :company_id]
    end
  end
end
