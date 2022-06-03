FactoryBot.define do
  factory :access_token, class: 'Doorkeeper::AccessToken' do
    token { 'bAR8P2esgQSvXyj9J1Sw9airMsL51UWrx9vrQ2qJRJA' }
    user
    application
  end
end
