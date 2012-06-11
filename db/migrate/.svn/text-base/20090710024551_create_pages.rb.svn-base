class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.column :name, :string, :null => false
      t.column :namespace_id, :integer, :null => false
      t.column :current_revision_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
