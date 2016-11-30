class AddSongToLyrics < ActiveRecord::Migration
  def change
    add_reference :lyrics, :song, index: true, foreign_key: true
  end
end
