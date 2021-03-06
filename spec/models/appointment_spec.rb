require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should belong_to :user }
  it { should belong_to :billionaire }
  it { should validate_presence_of :date }
  it { should validate_presence_of :city }
  it { should validate_length_of(:city).is_at_most(200) }
end
