class TasksController < ApplicationController
  def index
    @task = Task.first

    unless @task
      @task = Task.create!(
        title: "Tarefa Inicial",
        completed: false
      )
    end
  end

  def sync
    @task = Task.first

    unless @task
      @task = Task.create!(
        title: "Tarefa Inicial",
        completed: false
      )
    end

    user_id = params[:user_id] || 1
    user_data = UserSyncService.fetch_user(user_id)

    if user_data[:error]
      render json: { error: user_data[:error] }, status: :unprocessable_entity
    else
      @task.update!(
        external_user_name: user_data[:name],
        external_company: user_data[:company],
        external_city: user_data[:city]
      )

      render json: {
        task: {
          id: @task.id,
          title: @task.title,
          completed: @task.completed,
          external_user_name: @task.external_user_name,
          external_company: @task.external_company,
          external_city: @task.external_city
        }
      }
    end
  end
end
