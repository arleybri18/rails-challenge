class CreateBenefits < ActiveRecord::Migration[6.1]
  def change
    create_table :benefits do |t|
      t.date :month
      t.float :amount
      t.references :employee

      t.timestamps
    end
  end
end
