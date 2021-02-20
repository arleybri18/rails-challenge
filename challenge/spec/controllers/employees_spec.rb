require "rails_helper"

RSpec.describe EmployeesController, :type => :controller do
  fixtures :employees

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template("index")
    end

    it "assigns @employees" do
      get :index
      expect(assigns(:employees)).to eq(Employee.all)
    end
  end

  describe "GET result" do
    it "respond to result route" do
      get :result, format: :csv
      expect(response.status).to eq(200)
    end

    it "generate CSV" do
      get :result, format: :csv
      expect(response.header['Content-Type']).to include 'text/csv'
      expect(response.body).to include('Name,Email,Start date,Total benefit')
      expect(response.body).to include(Employee.first.name)
    end
  end
end
