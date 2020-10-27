module PlantsChats
  class PlantPolicy < ApplicationPolicy
    def index?
      record.user == user
    end
  end
end