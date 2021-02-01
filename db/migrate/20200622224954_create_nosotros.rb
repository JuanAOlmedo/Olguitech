class CreateNosotros < ActiveRecord::Migration[6.0]
  def change
    create_table :nosotros do |t|

      t.timestamps
    end
  end
end
