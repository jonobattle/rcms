require 'spec_helper'

describe "pages/new" do
  before(:each) do
    assign(:page, stub_model(Page,
      :title => "MyString",
      :body => "MyText",
      :parent_page_id => 1,
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pages_path, :method => "post" do
      assert_select "input#page_title", :name => "page[title]"
      assert_select "textarea#page_body", :name => "page[body]"
      assert_select "input#page_parent_page_id", :name => "page[parent_page_id]"
      assert_select "input#page_slug", :name => "page[slug]"
    end
  end
end
