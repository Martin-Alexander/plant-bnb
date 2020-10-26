class PlantInterestPolicy < ApplicationPolicy
  def create?
    record.plant.public
  end
end
