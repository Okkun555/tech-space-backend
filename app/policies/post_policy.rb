class PostPolicy < ApplicationPolicy
  def create?
    has_profile?
  end

  def destroy?
    record_owner?
  end
end
