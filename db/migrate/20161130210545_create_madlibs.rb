class CreateMadlibs < ActiveRecord::Migration
  def change
    create_table :madlibs do |t|

      t.timestamps null: false
    end
  end
end
