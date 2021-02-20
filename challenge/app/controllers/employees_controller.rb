class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def result
    respond_to do |format|
      format.csv { send_data Employee.to_csv, filename: "employees_#{Time.now}.csv", status: :ok }
    end
  end
end
