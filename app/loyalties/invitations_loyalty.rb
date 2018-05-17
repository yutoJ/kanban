class InvitationsLoyalty < ApplicationLoyalty
  attr_reader :user, :invitaion

  def initialize(user, invitaion)
    @user = user
    @invitaion = invitaion
  end

  def create?
    invitaion.project.user_id == user.id
  end

  def accept?
    invitaion.invitee_id == user.id
  end
end
