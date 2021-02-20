require 'rails_helper'

RSpec.describe Employee do
  fixtures :employees

  let(:employee) { employees(:employee_1) }

  context 'Validate database columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:start_date).of_type(:datetime) }
    it { should have_db_column(:employee_invite_id).of_type(:integer) }
    it { should have_db_index(:employee_invite_id) }
  end

  context 'Validate associations' do
    it { should belong_to(:employee_invite) }
    it { should have_many(:benefits) }
  end

  context 'Validate class' do
    it 'validate class include to_csv method' do
      expect(subject.class).to respond_to(:to_csv)
    end

    it 'validate object creation' do
      expect(employee).to be_an_instance_of Employee
    end

    it 'should return total benefit of employee' do
      expect(employee.total_benefit).to eq(employee.benefits.sum(:amount))
    end
  end

  context 'Validate CSV file generation' do
    it 'should generate csv headers' do
      csv_data = subject.class.to_csv.split("\n").map {|row| row.split(',') }
      months = Benefit.months.map { |m| m.strftime('%B-%Y') }

      expect(csv_data[0]).to include('Name')
      expect(csv_data[0]).to include('Email')
      expect(csv_data[0]).to include('Start date')
      expect(csv_data[0]).to include('Total benefit')
      
      months.each do |month|
        expect(csv_data[0]).to include(month)
      end
    end

    it 'should generate csv employees data' do
      csv_data = subject.class.to_csv.split("\n").map {|row| row.split(',') }
      employees = Employee.all

      expect(csv_data.size - 1).to eq employees.size

      employees.each_with_index do |employee, index|
        expect(csv_data[index + 1]).to include(employee.name)
        expect(csv_data[index + 1]).to include(employee.email)
        expect(csv_data[index + 1]).to include(employee.start_date)
        expect(csv_data[index + 1]).to include(employee.benefits.group(:month).average(:amount).values.join(","))
      end
    end
  end
end
