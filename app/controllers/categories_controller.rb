class CategoriesController < ApplicationController

def index
  @categories = Category.all
  @new_category = current_user.categories.build
  authorize @categories
end

def show
  @category = Category.find(params[:id])
  @todo = @category.todos  
  @new_todo = current_user.todos.build
end

def edit
  @category = Category.find(params[:id])
  authorize @category
end

def create
  @category = current_user.categories.build(category_params)
  authorize @category
  if @category.save
    flash[:notice] = "Category was saved."
    redirect_to :action => "index"
  else
    flash[:error] = "There was an error saving the category. Please try again."
    redirect_to :action => "index"
  end

end

def update
  @category = Category.find(params[:id])
  authorize @category

  if @category.update_attributes(category_params)
    flash[:notice] = "Category was updated."
    redirect_to :action => "index"
  else
    flash[:error] = "There was an error in upating the category. Please try again."
    redirect_to :action => "index"
  end
end

def destroy
  @category = Category.find(params[:id])
  authorize @category

  if @category.destroy
    flash[:notice] = "Category was deleted successfully."
    redirect_to :action => "index"
  else
    flash[:error] = "There was an error deleting the category."
    redirect_to :action => "index"
  end
end

private

def category_params
  params.require(:category).permit(:body)
end
  
end