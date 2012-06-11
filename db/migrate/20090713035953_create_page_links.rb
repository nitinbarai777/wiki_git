class CreatePageLinks < ActiveRecord::Migration
  def self.up
    create_table :page_links do |t|
      t.column :page_id, :integer, :null => false
      t.column :link_id, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :page_links
  end
end
