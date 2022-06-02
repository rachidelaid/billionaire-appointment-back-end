FactoryBot.define do
  factory :user do
    name { 'Pedro Guerreiro' }
    username { 'pepedro1' }
    role { 'user' }
    email { 'pedro@gmail.com' }
    password { '123456' }
  end
end
