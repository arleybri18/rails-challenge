# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

if Rails.env.development?
  100.times do
    invite = EmployeeInvite.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      start_date: Faker::Date.between(from: 1.year.ago.to_date, to: Date.today)
    )

    next if Random.rand(10) < 3

    ActiveRecord::Base.transaction do
      employee = Employee.create(
        name: invite.name,
        email: invite.email,
        start_date: invite.start_date,
        employee_invite: invite
      )

      (invite.start_date.to_date..Date.today)
        .select { _1.day == 1 }
        .each do |date|
          Benefit.create(
            month: date,
            amount: Random.rand(100),
            employee: employee
          )
        end
    end
  end
end
