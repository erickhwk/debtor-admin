class CreateLawsuits < ActiveRecord::Migration[7.1]
  def change
    create_table :lawsuits do |t|
      t.string :alias
      t.integer :category
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :tenancy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
