class CreateRevisions < ActiveRecord::Migration
  def self.up
    create_table :revisions do |t|
      t.column :page_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :content, :text, :null => false
      t.column :html, :text
      t.column :changes, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :revisions
  end
end
