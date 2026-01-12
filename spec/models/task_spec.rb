require 'rails_helper'

RSpec.describe Task, type: :model do
   describe 'validations' do
    it { should validate_presence_of(:title) }
  end
  describe 'database columns' do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:completed).of_type(:boolean) }
    it { should have_db_column(:external_user_name).of_type(:string) }
    it { should have_db_column(:external_company).of_type(:string) }
    it { should have_db_column(:external_city).of_type(:string) }
  end

  describe 'instance' do
    it 'can be created with valid attributes' do
      task = build(:task)
      expect(task).to be_valid
    end

    it 'can be created as completed' do
      task = create(:task, :completed)
      expect(task.completed).to be true
    end

    it 'can be created with external data' do
      task = create(:task, :with_external_data)
      expect(task.external_user_name).to be_present
      expect(task.external_company).to be_present
      expect(task.external_city).to be_present
    end
  end
end
