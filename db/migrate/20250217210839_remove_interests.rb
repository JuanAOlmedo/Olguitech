class RemoveInterests < ActiveRecord::Migration[8.0]
  def change
      drop_table :interests
  end
end
