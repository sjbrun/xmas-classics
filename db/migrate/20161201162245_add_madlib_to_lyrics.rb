class AddMadlibToLyrics < ActiveRecord::Migration
  def change
    add_reference :lyrics, :madlib, index: true, foreign_key: true
  end
end
