class ChangeSericeToGeneral < ActiveRecord::Migration
  def change
    Service.where(type: 'Service').each do |service|
      service.type = 'GeneralService'
      service.save!
    end
  end
end
