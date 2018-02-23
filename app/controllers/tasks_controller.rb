class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.where(:level=>1, :user_id=>current_user.id)
  end

  def descendant
    @tasks = Task.where(:user_id=>current_user.id, :descendant=>true)
  end

  def new
    if @task ||= Task.find_by(:id=>params[:format].to_i)
      @task.descendant = false
      @task.save
    end
    @relational = Relational.new
    @newTask = Task.new
  end

  def create
    @newTask = Task.new(task_params)
    @newTask.user_id = current_user.id
    @newTask.descendant = true
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
    @task = @newTask
  end

  def update
    if @task.update(task_params)
      redirect_to :controller=>"tasks", :action=>"show", :id=>@task.parent_task.ids.first, notice: "タスクを編集しました"
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
    params.require(:task).permit(:title, :content, :level)
  end
  def relational_params
    params.require(:relational).permit(:parent_id)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
