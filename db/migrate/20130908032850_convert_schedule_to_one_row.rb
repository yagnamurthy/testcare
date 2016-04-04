class ConvertScheduleToOneRow < ActiveRecord::Migration
  def change
  	drop_table :schedules

    create_table :schedules do |t|
    	t.boolean :monday_morning, :default => false
    	t.boolean :monday_afternoon, :defualt => false
    	t.boolean :monday_mid_afternoon, :default => false
    	t.boolean :monday_evening, :default => false
    	t.boolean :monday_overnight, :default => false

    	t.boolean :tuesday_morning, :default => false
    	t.boolean :tuesday_afternoon, :default => false
    	t.boolean :tuesday_mid_afternoon, :default => false
    	t.boolean :tuesday_evening, :default => false
    	t.boolean :tuesday_overnight, :default => false

    	t.boolean :wednesday_morning, :default => false
    	t.boolean :wednesday_afternoon, :default => false
    	t.boolean :wednesday_mid_afternoon, :default => false
    	t.boolean :wednesday_evening, :default => false
    	t.boolean :wednesday_overnight, :default => false

    	t.boolean :thursday_morning, :default => false
    	t.boolean :thursday_afternoon, :default => false
    	t.boolean :thursday_mid_afternoon, :default => false
    	t.boolean :thursday_evening, :default => false
    	t.boolean :thursday_overnight, :default => false

    	t.boolean :friday_morning, :default => false
    	t.boolean :friday_afternoon, :default => false
    	t.boolean :friday_mid_afternoon, :default => false
    	t.boolean :friday_evening, :default => false
    	t.boolean :friday_overnight, :default => false

    	t.boolean :saturday_morning, :default => false
    	t.boolean :saturday_afternoon, :default => false
    	t.boolean :saturday_mid_afternoon, :default => false
    	t.boolean :saturday_evening, :default => false
    	t.boolean :saturday_overnight, :default => false

    	t.boolean :sunday_morning, :default => false
    	t.boolean :sunday_afternoon, :default => false
    	t.boolean :sunday_mid_afternoon, :default => false
    	t.boolean :sunday_evening, :default => false
    	t.boolean :sunday_overnight, :default => false    	

    	t.references :user
    end

  end
end
