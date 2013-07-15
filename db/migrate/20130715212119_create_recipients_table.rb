class CreateRecipientsTable < ActiveRecord::Migration
  def up
    create_table :recipients do |t|
      t.string :name
      t.date :birthday
      t.references :user
      t.timestamps
    end
  end

  def down
    drop_table :recipients
  end
end
