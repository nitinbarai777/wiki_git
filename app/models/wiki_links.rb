class WikiLinks < WikiCloth::WikiLinkHandler

  def initialize(base_href="")
    @base_href = base_href
  end

  def categories
    @categories ||= []
  end

  def categories=(val)
    @categories = val
  end

  def languages
    @languages ||= []
  end

  def languages=(val)
    @languages = val
  end

  def url_for(page)
    page.gsub(/^[a-z]|\s+[a-z]/) { |a| a }.gsub(/\s+/,'_')
  end

  def section_link(section)
    @base_href + "/edit?section=#{section}"
  end

  def link_attributes_for(page)
     { :href => @base_href + url_for(page) }
  end

  def link_for_resource(prefix, resource, options=[])
    ret = ""
    prefix_name = prefix
    prefix = Namespace.find_by_name(prefix.strip.downcase)
    if !prefix.nil? && (prefix.interwiki == true || prefix.interwiki == 't')
      ret += elem.a({ :href => prefix.interwiki_url + prefix.name + ":" + resource }) { |x| x << "#{prefix.name}:#{resource}" }
    else
      unless prefix.nil?
        case
        when ["file","media","image"].include?(prefix.name)
          ret += wiki_image(resource,options)
        when prefix.name == "category"
          self.categories << resource
        else
          ret += link_for("#{prefix.name.capitalize}:#{resource}",options[0])
        end
      else
        self.languages << { :lang => prefix_name, :resource => resource }
      end
    end

    ret
  end

end
