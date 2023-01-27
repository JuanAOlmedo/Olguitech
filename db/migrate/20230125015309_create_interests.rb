class CreateInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :interests do |t|
      t.integer :contacto_id
      t.integer :record_id
      t.string :record_type

      t.timestamps
    end
  end
end
