require "rails_helper"

RSpec.describe EmployeeInvite do
  fixtures :employee_invites

  let(:invite) { employee_invites(:invite_1) }

  context "Validate database columns" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:status).of_type(:string).with_options(default: 'INVITED') }
    it { should have_db_column(:start_date).of_type(:datetime) }
  end

  context "Validate associations" do
    it { should have_one(:employee) }
  end

  context "Validate object" do
    it "validate object creation" do
      expect(invite).to be_an_instance_of EmployeeInvite
    end
  end
end
