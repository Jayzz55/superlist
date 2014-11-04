 class UserPolicy < ApplicationPolicy
  def index?
    user == record
  end
 end