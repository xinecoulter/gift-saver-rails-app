class CreateUsersTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password_hash
      t.string :password_salt
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end