module UsersHelper

  def _admin?
    current_user.admin?
  end

  def _trainer?
    current_user.trainer?
  end

  def _trainee?
    current_user.trainee?
  end
end
