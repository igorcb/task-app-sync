class TaskCardComponent < ViewComponent::Base
  def initialize(task:)
    @task = task
  end

  attr_reader :task
end
