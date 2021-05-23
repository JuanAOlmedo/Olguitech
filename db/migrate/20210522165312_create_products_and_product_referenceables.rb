class CreateProductsAndProductReferenceables < ActiveRecord::Migration[6.1]
    def change
        create_table :product_referenceables do |t|
            t.integer :referenceable_id
            t.string :referenceable_type

            t.integer :product_id

            t.timestamps
        end

        create_table :products do |t|
            t.string :title 
            t.string :title2

            t.string :description
            t.string :description2

            t.timestamps
        end
    end
end
