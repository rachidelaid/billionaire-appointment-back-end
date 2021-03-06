require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :appointments }
  it { should validate_presence_of :name }
  it { should validate_presence_of :username }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_length_of(:name).is_at_most(200) }
  it { should validate_length_of(:username).is_at_most(20) }
end
