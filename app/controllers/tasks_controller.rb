class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new 
    @task = Task.new
  end

  def show 
  end

  def edit

  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[notice] = "Successfully Created"
      redirect_to task_path(@task)
    else
      render 'new'
    end
  end

  def update 
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private 

  def set_tasks
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :priority, :due_date, :user_id)
  end

end
