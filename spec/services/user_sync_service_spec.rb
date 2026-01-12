require 'rails_helper'

RSpec.describe UserSyncService do
  describe '.fetch_user' do
    let(:user_id) { 1 }
    let(:api_response) do
      {
        'name' => 'Leanne Graham',
        'company' => { 'name' => 'Romaguera-Crona' },
        'address' => { 'city' => 'Gwenborough' }
      }
    end

    before do
      stub_request(:get, "https://jsonplaceholder.typicode.com/users/#{user_id}")
        .to_return(
          status: 200,
          body: api_response.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'fetches user data from the API' do
      result = UserSyncService.fetch_user(user_id)

      expect(result[:name]).to eq('Leanne Graham')
      expect(result[:company]).to eq('Romaguera-Crona')
      expect(result[:city]).to eq('Gwenborough')
    end

    context 'when API returns error' do
      before do
        stub_request(:get, "https://jsonplaceholder.typicode.com/users/#{user_id}")
          .to_return(status: 500)
      end

      it 'returns error message' do
        result = UserSyncService.fetch_user(user_id)
        expect(result[:error]).to eq('Failed to fetch user data')
      end
    end

    context 'when network error occurs' do
      before do
        stub_request(:get, "https://jsonplaceholder.typicode.com/users/#{user_id}")
          .to_raise(StandardError.new('Network error'))
      end

      it 'returns error message' do
        result = UserSyncService.fetch_user(user_id)
        expect(result[:error]).to eq('Network error')
      end
    end
  end
end
