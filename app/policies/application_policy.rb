# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def profile
    user&.profile
  end

  def has_profile?
    user.present? && user.profile.present?
  end

  def record_owner?
    has_profile? && record.respond_to?(:profile_id) && record.profile_id == profile.id
  end

  def index?
    has_profile?
  end

  def show?
    has_profile?
  end

  def create?
    has_profile?
  end

  def new?
    create?
  end

  def update?
    record_owner?
  end

  def edit?
    update?
  end

  def destroy?
    record_owner?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
