class SpecialController < ApplicationController

  layout "special"

  def handle
    data = params[:data].split("/")
    resource = data[0]
    options = data.size > 1 ? data[1..-1] : []

    case resource
    when "Special:RandomPage"
      page = Page.find(:first, :conditions => { :namespace_id => Page.default_namespace }, :order => "RAND()")
      redirect_to :controller => "pages", :action => "show", :id => page.url_slug
      return
    when "Special:RecentChanges"
      @changelog = Revision.find(:all, :order => "id DESC", :limit => 50)
      render :action => "changelog"
      return
    when "Special:Search"
      url_query = options.join(" ")
      @query = url_query.blank? ? params[:query] : url_query
      render :action => "search"
      return
    when "Special:WhatLinksHere"
      @page = Page.find_by_name(options[0])
      render :action => "links"
      return
    end
    render :text => resource, :layout => "special"
  end

end
