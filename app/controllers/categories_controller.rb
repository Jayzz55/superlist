class CategoriesController < ApplicationController

def index
  @categories = Category.all
end

def create
  @category = Category.new(category_params)
  if @category.save
      flash[:notice] = "Category was saved."
    else
      flash[:error] = "There was an error saving the category. Please try again."
    end

end

private

def cateogry_params
  params.require(:category).permit(:body)
end
  
end