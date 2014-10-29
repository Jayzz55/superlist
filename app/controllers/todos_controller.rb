class TodosController < ApplicationController
  respond_to :html, :js

  def create
    @todo = current_user.todos.build(todo_params)
    @todo.user = current_user
    @new_todo = current_user.todos.build
    authorize @todo


    if @todo.save
      flash[:notice] = "Todo was saved."
      redirect_to current_user
    else
      flash[:error] = "There was an error saving the todo item. Please try again."
      redirect_to current_user
    end

  end

  def destroy
    @todo = current_user.todos.find(params[:id])
    authorize @todo

    if @todo.destroy
      flash[:notice] = "Todo item was removed."
    else
      flash[:error] = "Todo item couldn't be deleted. Try again."
    end

    respond_with(@todo) do |format|
      format.html { redirect_to current_user }
    end

   end

  def destroy_multiple
    @todo = Todo.destroy(params[:todos])
    flash[:notice] = "Todo items were removed."
    redirect_to current_user
  end

  private

  def todo_params
    params.require(:todo).permit(:body)
  end

end