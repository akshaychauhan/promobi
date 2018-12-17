class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @project = Project.where(id: params[:project_id]).first
    if current_user.admin?
      @tasks = @project.tasks
    else
      @tasks = @project.tasks.where(user_id: current_user.id)
    end
  end

  def show
    @project = Project.where(id: params[:project_id]).first
    # raise (@task.status != Task::STATUS['new']).inspect
  end

  def new
    @task = Task.new
    @project = Project.where(id: params[:project_id]).first
    @developers = @project.users.where(type: "Developer")
  end

  def edit
    @project = Project.where(id: params[:project_id]).first
    @developers = @project.users.where(type: "Developer")
  end

  def create
    @project = Project.where(id: params[:project_id]).first
    @task = @project.tasks.new(task_params)
    @developers = @project.users.where(type: "Developer")

    respond_to do |format|
      if @task.save
        format.html { redirect_to [@project,@task], notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.where(id: params[:project_id]).first
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to [@project, @task], notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    @project = Project.where(id: params[:project_id]).first
    @task = Task.where(id: params[:id]).first
    @task.status = Task::STATUS[params[:status]]
    respond_to do |format|
      if @task.save
        format.html { redirect_to [@project, @task], notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :desc, :user_id)
    end
end
