class SubcategoriesController < ApplicationController
  def new
    @category = current_user.categories.find(params[:category_id])
    @subcategory = @category.subcategories.new
  end
end
