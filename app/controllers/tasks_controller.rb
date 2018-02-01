class TasksController < ApplicationController
  before_action :set_task, only: [:show]
  def index
    @tasks = Task.where(:level=>1)
  end

  def new
    @task = Task.find_by(:id=>params[:format].to_i)
    @relational = Relational.new
    @newTask = Task.new
  end

  def create
    @newTask = Task.new(task_params)
    if @newTask.save
      @relational = Relational.new(params.require(:relational).permit(:parent_id).merge(children_id: @newTask.id))
      @relational.save
      redirect_to task_path(@newTask.parent_task), notice: "タスクを作成しました"
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

  def relational_params
    params.require(:relational).permit(:parent_id)
  end

  def has_children?(task)
    task.children_tasks.any?
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
