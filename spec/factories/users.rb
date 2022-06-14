FactoryBot.define do
  factory :user do
    name { 'Pedro Guerreiro' }
    username { 'pepedro1' }
    role { 'user' }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { '123456' }
  end
end
