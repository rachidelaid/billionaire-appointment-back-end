require 'rails_helper'

RSpec.describe Billionaire, type: :model do
  it { should have_many :appointments }
  it { should validate_presence_of :name }
  it { should validate_presence_of :title }
  it { should validate_presence_of :image }
  it { should validate_presence_of :description }
  it { should validate_numericality_of :price }
  it { should validate_length_of(:name).is_at_most(200) }
  it { should validate_length_of(:title).is_at_most(200) }
end
