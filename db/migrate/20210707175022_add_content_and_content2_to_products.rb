class AddContentAndContent2ToProducts < ActiveRecord::Migration[6.1]
    def change
        add_column :products, :content, :text
        add_column :products, :content2, :text
    end
end
