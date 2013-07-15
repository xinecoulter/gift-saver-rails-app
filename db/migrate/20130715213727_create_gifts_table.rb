class CreateGiftsTable < ActiveRecord::Migration
  def up
    create_table :gifts do |t|
      t.string :name
      t.string :category
      t.text :image  # image url
      t.string :price
      t.text :url  # url to product on Amazon
      t.integer :rating, :default => 5
      t.timestamps
    end
  end

  def down
    drop_table :gifts
  end
end
