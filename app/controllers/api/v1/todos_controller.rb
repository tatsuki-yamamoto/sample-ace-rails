class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: %i[show update destroy]

  # GET /api/v1/todos
  # GET /api/v1/todos.json
  def index
    @todos = Todo.all
  end

  # GET /api/v1/todos/1
  # GET /api/v1/todos/1.json
  def show; end

  # POST /api/v1/todos
  # POST /api/v1/todos.json
  def create
    @todo = Todo.new(todo_params)
    @todo.save!
    render :show
  end

  # PATCH/PUT /api/v1/todos/1
  # PATCH/PUT /api/v1/todos/1.json
  def update
    @todo.update!(todo_params)
    render :show
  end

  # DELETE /api/v1/todos/1
  # DELETE /api/v1/todos/1.json
  def destroy
    @todo.destroy!
    render_success_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.fetch(:todo, {})
          .permit(
            :title,
            :description,
            :status
          )
  end
end
