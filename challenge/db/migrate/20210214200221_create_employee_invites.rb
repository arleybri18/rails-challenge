class CreateEmployeeInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_invites do |t|
      t.string :name
      t.string :email
      t.string :status, default: 'INVITED'
      t.timestamp :start_date

      t.timestamps
    end
  end
end
