class User::UserJob < Struct.new(:user_id)
  def perform
    @user = User.find(self.user_id)
    @user.regenerate_styles!
  end
end