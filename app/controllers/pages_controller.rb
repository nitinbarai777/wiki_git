class PagesController < ApplicationController

  before_filter :require_user	
  layout "default"

  include WikiCloth

  caches_page :show

  def index
	@pages = Page.paginate(:conditions => ["namespace_id = 1"], :page => params[:page], :per_page => 10, :order => 'created_at DESC')
    #redirect_to :action => "show", :id => "Main_Page"
  end

  def show
    if params[:rev_id].blank?
      @page = Page.find_by_name(params[:id])
    else
      @page = Page.find_by_name(params[:id],false)
      @page.load_revision(params[:rev_id])
    end
    @wiki = WikiCloth.new({ :data => @page.content, :params => @page.params, 
	:link_handler => WikiLinks.new("http://#{request.host_with_port}/wiki/") })
  end

  def new
    @pageNew = Page.new
  end

  def create
    @pageNew = Page.new(params[:pageNew])
	  if params[:pageNew][:name].blank?
		flash[:error_page] = 'Name can not be blank.'
		redirect_to :action => "new"
	  elsif params[:pageNew][:content].blank?
		flash[:error_page] = 'Content can not be blank.'
		redirect_to :action => "new"
 	  else	
		  if @pageNew.save
			flash[:notice] = 'page was successfully created.'
			redirect_to :action => "index"
		  else
			flash[:notice] = 'unprocessable_entity.'
			redirect_to :action => "new"
		  end
	  end	

  end

  def edit
    @page = Page.find_by_name(params[:id])
    if @page.new_record?
      @page.content = ""
      @page.changes = "page created"
	  flash[:notice] = 'page was successfully created.'
    end
  end

  def history
    @page = Page.find_by_name(params[:id])
  end

  def update
    @page = Page.find_by_name(params[:id])

    if @page.update_attributes(params[:page])
      flash[:notice] = "Page was successfully updated."
      redirect_to :action => "show", :id => @page.url_slug
    else
      render :action => "edit"
    end
  end
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

	#@revision = Revision.find(:all, :conditions => ["page_id = ?", params[:id]])
	Revision.delete_all(:page_id => params[:id])
    flash[:notice] = "Page was successfully deleted."
	redirect_to :action => "index"
  end

end
