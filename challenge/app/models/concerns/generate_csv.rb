module GenerateCsv
  extend ActiveSupport::Concern

  class_methods do
    # to_csv - class method return csv data file,
    # @return csv file, call build_data_to_csv method to get headers and rows to file
    def to_csv
      data = build_data_to_csv
      CSV.generate(headers: true) do |csv|
        csv << (data[:headers])
        data[:rows].each do |row|
          csv << row
        end
      end
    end

    private

    # build_data_to_csv - class method return csv data file, overwrite this method in every class
    # to return the corresponding data
    # @return hash with headers and rows
    def build_data_to_csv
      { headers: [],
        rows: [[]] }
    end
  end
end
