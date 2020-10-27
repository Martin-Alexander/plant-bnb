class MyPlantsController < ApplicationController
  def index
    @plants = policy_scope(Plant).where(user: current_user)
  end
end
