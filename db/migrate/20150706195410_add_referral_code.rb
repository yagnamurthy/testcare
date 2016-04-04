class AddReferralCode < ActiveRecord::Migration
  def change
    User.all.each do |u|
      u.generate_referral_code
      puts "#{u.id} - Updated Referral Code"
    end
  end
end
