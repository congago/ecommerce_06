class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
<<<<<<< HEAD
      t.text :productname
      t.integer :productPrice
      t.boolean :productStatus
      t.text :productDescription
      t.integer :rate
      t.string :upPicture
=======
      t.text :name
      t.integer :price
      t.boolean :is_status
      t.text :description
      t.integer :rate
      t.string :up_picture
>>>>>>> 8659067fdccb53a51b78c5e6b85551bb13de849e
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :products, [:category_id, :created_at]
  end
end
