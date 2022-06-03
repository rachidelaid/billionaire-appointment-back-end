FactoryBot.define do
  factory :billionaire do
    id { 1 }
    name { 'Pedro Guerreiro' }
    title { 'Amazon CEO' }
    image { 'https://github.com/orozCoding/billionares-pictures/blob/main/round_pictures/pc_jeff.png?raw=true ' }
    description { 'description' }
    price { '123456' }
  end
end
