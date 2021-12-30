class DropMainsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :mains
  end
end
