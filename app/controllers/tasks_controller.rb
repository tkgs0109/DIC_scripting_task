class TasksController < ApplicationController
  before_action :set_task, only: [:show, :new]
  def index
    @tasks = Task.where(:level=>1)
  end

  def new
    @newTask = Task.new
  end

  def create
    @newTask = Task.new(task_params)
    if @task.nil?
      @newTask.level = 1
    else
      @newTask.level = @task.level + 1
    end
    if @newTask.save
      redirect_to tasks_path, notice: "タスクを作成しました"
    else
      render 'new'
    end
  end

  def show
    @tasks = @task.children_tasks
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private
  def task_params
    params.require(:task).permit(:user_id, :title, :content, :level)
  end

  def has_children?(task)
    task.children_tasks.any?
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
