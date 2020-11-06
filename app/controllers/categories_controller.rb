class CategoriesController < ApplicationController
  def show
    authorize(Category)

    @category = Category.find(params[:id])

    @plants = policy_scope(Plant)
      .joins(plant_categories: :category)
      .where(categories: { id: @category.id })
      .order("user_id = #{current_user&.id || 0}")
      .includes([
        { user: { profile_picture_attachment: :blob }},
        { favourites: :user }
      ])
      .with_attached_cover_photo
  end
end