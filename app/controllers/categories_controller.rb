class CategoriesController < ApplicationController
  def show
    authorize(Category)

    @category = Category.find(params[:id])

    @plants = policy_scope(Plant).joins(plant_categories: :category).where(categories: { id: @category.id }).includes(:user)
  end
end