class TodosController < ApplicationController
  respond_to :html, :js

  def create
    @category = Category.find(params[:category_id])
    @todo = current_user.todos.build(todo_params)
    @todo.category = @category
    @new_todo = current_user.todos.build
    authorize @todo


    if @todo.save
      flash[:notice] = "Todo was saved."
      redirect_to @category
    else
      flash[:error] = "There was an error saving the todo item. Please try again."
      redirect_to @category
    end

  end

  def destroy
    @category = Category.find(params[:category_id])
    @todo = @category.todos.find(params[:id])
    authorize @todo

    if @todo.destroy
      flash[:notice] = "Todo item was removed."
      redirect_to @category
    else
      flash[:error] = "Todo tiem couldn't be deleted. Try again."
      redirect_to @category
    end

   end

  private

  def todo_params
    params.require(:todo).permit(:body)
  end

end