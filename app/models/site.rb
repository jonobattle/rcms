class Site
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :home_page_slug, type: String
end
