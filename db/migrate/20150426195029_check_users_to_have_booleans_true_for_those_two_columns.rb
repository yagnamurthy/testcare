class CheckUsersToHaveBooleansTrueForThoseTwoColumns < ActiveRecord::Migration
  def up
    User.all.each do |user|
      user.congrats_modal = true
      user.edit_profile_modal = true
      user.save!(validate: false)
    end
  end

  def down
  end
end
