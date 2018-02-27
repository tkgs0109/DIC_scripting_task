class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_confirm

  def index
    @tasks = Task.where(:level=>1, :user_id=>current_user.id)
  end

  def descendant
    @descendant_ids = Task.descendant_tasks(current_user.id)
  end

  def new
    if @task ||= Task.find_by(:id=>params[:format].to_i)
      @task.save
    end
    @relational = Relational.new
    @newTask = Task.new
  end

  def create
    @newTask = Task.new(task_params)
    @newTask.user_id = current_user.id
    if @newTask.save
      if @newTask.level == 1
        redirect_to tasks_path, notice: "タスクを作成しました"
      else
        @relational = Relational.new(params.require(:relational).permit(:parent_id).merge(children_id: @newTask.id))
        @relational.save
        redirect_to :controller=>"tasks", :action=>"show", :id=>@newTask.parent_task.ids.first, notice: "タスクを作成しました"
      end
    else
      render 'new'
    end
  end

  def show
    @tasks = @task.children_tasks
  end

  def edit
    @newTask = @task
  end

  def update
    if @task.update(task_params) || @task.update(task_complete)
      unless @task.level == 1
        redirect_to task_path(@task.parent_task.first), notice: "タスクを編集しました"
      else
        redirect_to tasks_path, notice: "タスクを編集しました"
      end
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end


  private
  def task_params
    params.require(:task).permit(:title, :content, :level, :done)
  end
  # def task_complete
  #   params.require(:task).permit(:done)
  # end
  def relational_params
    params.require(:relational).permit(:parent_id)
  end
  def set_task
    @task = Task.find(params[:id])
  end
  def login_confirm
    unless user_signed_in? then
      redirect_to new_user_session_path
    end
  end
  def complete_task
    if @task.done == false
      @task.done = true
      @task.save
    else
      @task.done = false
      @task.save
    end
  end
end
