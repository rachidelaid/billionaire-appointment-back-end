FactoryBot.define do
  factory :application, class: 'Doorkeeper::Application' do
    name { 'web client' }
    uid { '5HQ7dTk0E19iqnVKOq54AS9q5R97-dyNw3vdnhXBpos' }
    secret { 'RhEkeazVmLeVqoD97lanUFbv2lhEMKRVX9UDE3oTH7c' }
  end
end
