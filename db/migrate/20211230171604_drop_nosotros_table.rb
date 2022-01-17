class DropNosotrosTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :nosotros
  end
end
