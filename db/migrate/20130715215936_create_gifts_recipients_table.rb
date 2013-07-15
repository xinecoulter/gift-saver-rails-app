class CreateGiftsRecipientsTable < ActiveRecord::Migration
  def up
    create_table :gifts_recipients, :id => false do |t|
      t.references :gift
      t.references :recipient
    end
  end

  def down
    drop_table :gifts_recipients
  end
end
