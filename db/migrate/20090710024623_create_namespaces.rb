class CreateNamespaces < ActiveRecord::Migration
  def self.up
    create_table :namespaces do |t|
      t.column :name, :string, :null => false
      t.column :title, :string, :null => false, :default => "article"
      t.column :alias_for_id, :integer
      t.column :interwiki, :bool, :null => false, :default => false
      t.column :interwiki_url, :string
      t.column :talk_for_id, :integer
      t.timestamps
    end
    m = Namespace.create({:name=>"main"})
    h = Namespace.create({:name=>"help",:title=>"help page"})
    Namespace.create({:name=>"talk", :talk_for_id=>m.id})
    Namespace.create({:name=>"help_talk",:talk_for_id=>h.id})
    fi = Namespace.create({:name=>"file"})
    Namespace.create({:name=>"special",:title=>"special"})
    Namespace.create({:name=>"image", :alias_for_id => fi.id })
    t = Namespace.create({:name=>"template",:title=>"template"})
    Namespace.create({:name=>"template_talk",:talk_for_id=>t.id})
    Namespace.create({:name=>"media", :alias_for_id => fi.id })
    Namespace.create({:name=>"category"})

    # some initial interwiki links
    Namespace.create({:name=>"wikipedia", :interwiki => true, :interwiki_url => "http://en.wikipedia.org/wiki/"})
    Namespace.create({:name=>"mw", :interwiki => true, :interwiki_url => "http://www.mediawiki.org/wiki/"})

    Dir.foreach("#{RAILS_ROOT}/data") do |file|
      unless File.directory?("#{RAILS_ROOT}/data/#{file}")
        puts file
        page = Page.find_by_name(file,false)
        page.content = File.open("#{RAILS_ROOT}/data/#{file}") { |f| f.read }
        page.changes = "db:migrate"
        page.save()
      end
    end
  end

  def self.down
    drop_table :namespaces
  end
end
