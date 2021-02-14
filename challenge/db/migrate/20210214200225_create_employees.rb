class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.timestamp :start_date
      t.references :employee_invite

      t.timestamps
    end
  end
end
