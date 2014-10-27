class CategoriesController < ApplicationController

def index
  @categories = Category.all
  authorize @categories
end

def edit
  @category = Category.find(params[:id])
  authorize @category
end

def create
  @category = Category.new(category_params)
  authorize @category
  if @category.save
    flash[:notice] = "Category was saved."
  else
    flash[:error] = "There was an error saving the category. Please try again."
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

private

def category_params
  params.require(:category).permit(:body)
end
  
end