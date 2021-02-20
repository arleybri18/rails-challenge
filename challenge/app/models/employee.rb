class Employee < ApplicationRecord
  include ::GenerateCsv
  belongs_to :employee_invite
  has_many :benefits

  def total_benefit
    benefits.sum(:amount)
  end

  class << self
    private

    # build_data_to_csv - overwrite module method, build headers and rows to csv file,
    # add attributes of employee, and call months method of Benefit class for retrieve all
    # possible months that exist in the table
    # @return hash with headers and rows
    def build_data_to_csv
      attributes = ["name", "email", "start_date", "total_benefit"]
      months = Benefit.months
      { headers: build_header(attributes, months),
        rows: build_rows(attributes, months) }
    end

    # build_header - build headers to csv file
    # @attributes - array of attributes of an employee
    # @months - array of months of benefits
    # @return array with headers to csv file, attributes and months with Month-Year format
    def build_header(attributes, months)
      attributes.map { |a| a.gsub('_', ' ').capitalize } + months.map { |m| m.strftime("%B-%Y") }
    end

    # build_rows - build rows to csv file
    # @attributes - array of attributes of an employee
    # @months - array of months of benefits
    # @return array with rows to csv file, get the attributes for every employee,
    # get average amount of benefits grouped by month for employee,
    # create new array and match data with the month of the header, if match puts data else puts empty string,
    # finally merge in one array
    def build_rows(attributes, months)
      rows = []
      all.each do |employee|
        attr_arr = attributes.map{ |attr| employee.send(attr) }
        benefits = employee.benefits.group(:month).average(:amount)
        benefits_array = []
        months.each do |month|
          benefits_array << benefits[month] || ' '
        end
        attr_arr += benefits_array
        rows << attr_arr
      end
      rows
    end

  end
end
