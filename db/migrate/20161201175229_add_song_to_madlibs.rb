class AddSongToMadlibs < ActiveRecord::Migration
  def change
    add_reference :madlibs, :song, index: true, foreign_key: true
  end
end
