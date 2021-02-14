class Employee < ApplicationRecord
  belongs_to :employee_invite
  has_many :benefits
end
