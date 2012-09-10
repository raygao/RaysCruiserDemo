class ProtectedObject
  include Canable::Ables
  def updatable_by?(user)
    status = ((owner == user) || (user.user_role == URole.where({name: "admin"}).first))
    return status
  end

  def destroyable_by?(user)
    updatable_by?(user)
  end

  def viewable_by?(user)
    true #user can look at other people's object, just not able to change or remove it
  end

  def creatable_by?(user)
    true
  end
end