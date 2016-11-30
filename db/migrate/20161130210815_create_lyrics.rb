class CreateLyrics < ActiveRecord::Migration
  def change
    create_table :lyrics do |t|
      t.string :word
      t.string :part_of_speech

      t.timestamps null: false
    end
  end
end
