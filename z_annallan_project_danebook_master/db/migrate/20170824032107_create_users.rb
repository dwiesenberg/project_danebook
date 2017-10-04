class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :gender
      t.string :college
      t.string :hometown
      t.string :currently_lives
      t.string :phone
      t.text   :words_live
      t.text   :about_me
      t.datetime :dob
      t.string :auth_token
    end
    add_index :users, :auth_token, :unique => true
  end
end
