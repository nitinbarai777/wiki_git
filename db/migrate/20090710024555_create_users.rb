class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :email, :string, :null => false
      t.column :password, :string, :null => false
      t.column :last_ip_address, :string, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
