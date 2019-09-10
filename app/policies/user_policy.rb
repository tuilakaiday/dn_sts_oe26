class Admin::UserPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end
  class Admin::Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else user.trainer? || user.trainee?
        scope.where(activated: true)
      else
        scope.new
      end
    end
  end
end
