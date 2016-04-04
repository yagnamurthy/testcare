class ChangeHourlyTypeForAll < ActiveRecord::Migration
  def change
    Contract.where(hourly_type: nil).each do |c|
        c.hourly_type = 'Hour'
        c.save!(validate: false)
    end
  end
end
