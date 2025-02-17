class RenameContactosToMessages < ActiveRecord::Migration[8.0]
    def change
        rename_table :contactos, :messages

        change_table :messages do |t|
            t.remove :preference, :preference2
            t.rename :message, :content
        end
    end
end
