class Page < ActiveRecord::Base

  has_many :revisions, :order => "id DESC"
  belongs_to :namespace
  belongs_to :current_revision, :class_name => "Revision", :foreign_key => "current_revision_id"

  attr_accessor :content
  attr_accessor :changes
  after_save :update_revision

  def update_revision
    unless self.content.blank?
      rev = Revision.create(:content => self.content, :changes => self.changes, :user_id => 1, :page_id => self.id)
    end
  end

  def has_discussion?
    false
  end

  def url_slug
    Page.url_slug_for(self.name, self.namespace.nil? ? nil : self.namespace.name)
  end

  def self.default_namespace
    @default_ns ||= Namespace.find_by_name("main")
  end

  def self.url_slug_for(page,ns=nil)
    if !Page.default_namespace.nil? && Page.default_namespace.name == ns.downcase
      url = page
    else
      url = (ns.nil? ? "" : ns.capitalize + ":") + page
    end
    url.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }.gsub(/\s+/,'_')
  end

  def load_revision(rev_id)
    tmp = self.revisions.find(rev_id)
    unless tmp.nil?
      self.content = tmp.content
    end
  end

  def self.find_by_name(name,preload_content=true)
    ns = nil
    if name =~ /^([a-zA-Z0-9\-_]+):(.*)/
      ns = Namespace.find_by_name($1.downcase)
      name = $2
    else
      ns = Namespace.find_by_name("main")
    end
    page = self.find(:first, :conditions => { :name => name, :namespace_id => ns.id })
    page = self.new({ :name => name, :namespace_id => ns.id }) if page.nil?
    return page if preload_content == false

    page.content = page.current_revision.content unless page.current_revision.nil?
    if page.content.blank?
      tmp = Page.find_by_name("Template:PageNotFound")
      page.content = tmp.content
    end
    return page
  end

  def print_name
    if !Page.default_namespace.nil? && Page.default_namespace.name == self.namespace.name
      self.name.gsub('_',' ')
    else
      ((self.namespace.nil? ? "" : self.namespace.name.capitalize + ":") + self.name).gsub("_"," ")
    end
  end

  def params
   { 'PAGENAME'  => self.print_name,
     'SITENAME'  => 'WikiCloth',
     'NAMESPACE' => self.namespace.nil? ? "Main" : self.namespace.name.capitalize }
  end

end
