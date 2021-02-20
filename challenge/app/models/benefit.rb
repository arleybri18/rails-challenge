class Benefit < ApplicationRecord
  belongs_to :employee

  # months - class method to get months of benefits
  # iterate over min and max month founded in the table
  # @return array with months min to max
  def self.months
    min = all.minimum(:month)
    max = all.maximum(:month)
    months = []

    while min <= max
      months << min
      min += 1.month
    end
    months
  end
end
