class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string

    User.find_each do |user|
      user.authentication_token = SecureRandom.hex
      user.save!
    end

    change_column :users, :authentication_token, :string, null: false
  end
end
