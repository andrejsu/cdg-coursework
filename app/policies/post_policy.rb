class PostPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def show?
    true
  end
end
