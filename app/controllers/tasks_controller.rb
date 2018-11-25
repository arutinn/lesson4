class TasksController < ApplicationController
  before_action :require_user

  def index
    @task = Task.new
    @user = User.find_by(id: params[:user_id])
    unless params[:user_id].nil?
      if @user.shared_tasks.include? @current_user.name.to_s
        @tasks = Task.for_dashboard(params).where(user_id: params[:user_id] || current_user)
      else
        current_user_tasks
      end
    else
      current_user_tasks
    end
  end

  def create
    @task = current_user.tasks.create(task_params)
    return if @task.invalid?
    @task.save
    redirect_to :root
  end

  def update
    task.update(update_task_params)
    head 200
  end

  def destroy
    Task.delete(params[:id])
    redirect_to :root
end

  private

  def current_user_tasks
    @tasks = Task.for_dashboard(params).where(user_id: current_user)
  end

  def task
    @task ||= current_user.tasks.find(params[:id])
  end

  def update_task_params
    params.require(:task).permit(:status)
  end

  def task_params
    params.require(:task).permit(:title, :description, :expire_at, :status)
  end
end
