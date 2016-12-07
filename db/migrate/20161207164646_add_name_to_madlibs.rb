class AddNameToMadlibs < ActiveRecord::Migration
  def change
    add_column :madlibs, :name, :string
  end
end
