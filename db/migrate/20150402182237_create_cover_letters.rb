class CreateCoverLetters < ActiveRecord::Migration
  def up
    create_table :cover_letters do |t|
      t.references :caregiver
      t.text :body
      t.timestamps null: false
    end

    Caregiver.all.each do |caregiver|
      if caregiver.cover_letter.nil?
        cover_letter = CoverLetter.create!
        caregiver.cover_letter = cover_letter
        caregiver.save!(validate: false)
      end
    end
  end

  def down
    drop_table :cover_letters
  end
end
