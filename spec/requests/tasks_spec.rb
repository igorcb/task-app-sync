require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    context 'when no task exists' do
      it 'creates a task and renders the index page' do
        expect {
          get tasks_path
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Gerenciador de Tarefas')
      end
    end

    context 'when task already exists' do
      let!(:task) { create(:task) }

      it 'does not create a new task' do
        expect {
          get tasks_path
        }.not_to change(Task, :count)

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST /tasks/sync" do
    let(:api_response) do
      {
        'name' => 'Leanne Graham',
        'company' => { 'name' => 'Romaguera-Crona' },
        'address' => { 'city' => 'Gwenborough' }
      }
    end

    before do
      stub_request(:get, "https://jsonplaceholder.typicode.com/users/1")
        .to_return(
          status: 200,
          body: api_response.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    context 'when task exists' do
      let!(:task) { create(:task) }

      it 'syncs user data successfully' do
        post sync_tasks_path, params: { user_id: 1 }

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response['task']['external_user_name']).to eq('Leanne Graham')
        expect(json_response['task']['external_company']).to eq('Romaguera-Crona')
        expect(json_response['task']['external_city']).to eq('Gwenborough')

        task.reload
        expect(task.external_user_name).to eq('Leanne Graham')
      end
    end

    context 'when no task exists' do
      it 'creates a task and syncs data' do
        expect {
          post sync_tasks_path, params: { user_id: 1 }
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response['task']['external_user_name']).to eq('Leanne Graham')
      end
    end

    context 'when API returns error' do
      before do
        stub_request(:get, "https://jsonplaceholder.typicode.com/users/1")
          .to_return(status: 500)
      end

      let!(:task) { create(:task) }

      it 'returns error response' do
        post sync_tasks_path, params: { user_id: 1 }

        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Failed to fetch user data')
      end
    end

    context 'with different user_id' do
       let(:user_2_response) do
        {
          'name' => 'Ervin Howell',
          'company' => { 'name' => 'Deckow-Crist' },
          'address' => { 'city' => 'Wisokyburgh' }
        }
      end

      before do
        stub_request(:get, "https://jsonplaceholder.typicode.com/users/2")
          .to_return(
            status: 200,
            body: user_2_response.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      let!(:task) { create(:task) }

      it 'syncs data for the specified user_id' do
        post sync_tasks_path, params: { user_id: 2 }

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response['task']['external_user_name']).to eq('Ervin Howell')
        expect(json_response['task']['external_company']).to eq('Deckow-Crist')
        expect(json_response['task']['external_city']).to eq('Wisokyburgh')
      end
    end
  end
end
