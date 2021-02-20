require 'rails_helper'

RSpec.describe Benefit do
  fixtures :benefits

  let(:benefit) { benefits(:benefit_1) }

  context 'Validate database columns' do
    it { should have_db_column(:month).of_type(:date) }
    it { should have_db_column(:amount).of_type(:float) }
    it { should have_db_column(:employee_id).of_type(:integer) }
    it { should have_db_index(:employee_id) }
  end

  context 'Validate associations' do
    it { should belong_to(:employee) }
  end

  context 'Validate class' do
    it 'validate object creation' do
      expect(benefit).to be_an_instance_of Benefit
    end
  end
end
