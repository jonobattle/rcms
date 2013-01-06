class Page
  include Mongoid::Document

  before_create { generate_slug }

  field :title, type: String
  field :body, type: String
  field :parent_page_slug, type: String
  field :slug, type: String



  # Parent serviceline of current serviceline if set
  def parent
    Page.find_by(slug: self.parent_page_slug) if self.parent_page_slug.present?
  end


  # Find the servicelines that would qualify to be parents of the current serviceline
  def availableParents

    available_pages = Page.where(:slug.ne => self.slug) if self.slug.present?
    available_pages = Page.all if !self.slug.present?

    valid_pages = []

    if available_pages
      available_pages.each do |sl|
        
        if sl.validHeirachy(self)
          valid_pages << [sl.title, sl.slug]
        end
    
      end
    end

    valid_pages
  end


  # Check if the provided serviceline qualifies as a valid parent without causing and infinite loop
  def validHeirachy(original)
    if self.parent.present? && self.parent.slug != original.slug
      self.parent.validHeirachy(original)
    elsif self.parent.present? && self.parent.slug == original.slug
      false
    else 
      true
    end
  end



  def generate_slug
    new_slug = self.title.parameterize.to_s

    # Check if the new slug already exists
    count = 0
    while Page.where(slug: new_slug).first
      count = count + 1
      new_slug = self.title.parameterize + "-" + count.to_s
      puts "Slug Exists: New version = " + new_slug.to_s
    end    

    self.slug = new_slug
  end  

end
