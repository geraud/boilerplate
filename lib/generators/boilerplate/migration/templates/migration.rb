class <%= migration_class_name %> < ActiveRecord::Migration

  def self.up

    create_table :<%= user_table_name %> do |t|
      # Authlogic
      t.string :crypted_password
      t.string :salt
      t.string :persistence_token, :null => false
      t.string :perishable_token
      t.string :single_access_token, :null => false
      t.integer :login_count,  :default => 0, :null => false
      t.integer :failed_login_count,:default => 0, :null => false
      t.datetime:current_login_at
      t.string :current_login_ip
      t.datetime :last_login_at
      t.string :last_login_ip
      t.datetime :last_request_at

      # Facebook connect
      t.integer:facebook_id
      t.string :facebook_access_token

      t.timestamps
    end

    #  add_index :<%= user_table_name %>, :session_id
    #  add_index :<%= user_table_name %>, :updated_at
  end

  def self.down
    drop_table :<%= user_table_name %>
  end
end
