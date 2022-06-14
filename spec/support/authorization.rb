def authorization(user = nil)
  let(:application) { FactoryBot.create(:application) }
  let(:current_user) { FactoryBot.create(:user, role: 'admin') } unless user
  let(:access_token) do
    FactoryBot.create(:access_token, application:, resource_owner_id: user ? user.id : current_user.id)
  end
  let(:Authorization) { "Bearer #{access_token.token}" }
end
