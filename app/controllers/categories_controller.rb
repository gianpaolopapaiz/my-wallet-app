class CategoriesController < ApplicationController
  before_action :set_account, only: [:edit, :update, :destroy]

  def index
    @categories = policy_scope(Category).order(name: :asc)
  end

  def new
    @category = current_user.categories.new
    authorize @category
  end

  def create
    @category = current_user.categories.new(categories_params)
    authorize @category
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(categories_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def categories_params
    params.require(:category).permit(:name, :description)
  end

  def set_account
    @category = current_user.categories.find(params[:id])
    authorize @category
  end
end
