class SiteController < ApplicationController

  def index

    @site = Site.first

    if !@site 
      # The website has not been generated yet, so lets create a blank one.
      generate_new_website
    end

    @page = Page.find_by(slug: @site.home_page_slug)

  end



  def show_page

    @page = Page.find_by(slug: params[:slug])

  end



private
    
  # No website already exists, so we'll generate a quick skeleton and then direct the user to make changes
  def generate_new_website

    page = Page.new 
    page.title = "Homepage"
    page.body = "Welcome to my homepage"
    page.save

    site = Site.new
    site.name = "New Website"
    site.description = "Welcome to my brand new website"
    site.home_page_slug = page.slug
    site.save

    index

  end

end