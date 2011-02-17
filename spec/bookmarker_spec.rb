require "rspec"
require "bookmarker"

describe Bookmarker do

  before :all do
    @bookmarker = Bookmarker.new({
			:base_url		=> 'http://localhost/JSPWiki/Wiki.jsp?page=',
			:path				=> 'input/',
			:key				=> 'MyProject',
			:separator	=> '.'
	  })
  end
  
  it "should generate bookmarks" do
    html = @bookmarker.generate_html
    html.should_not nil
    [
    	'http://localhost/JSPWiki/Wiki.jsp?page=MyProject',
    	'http://localhost/JSPWiki/Wiki.jsp?page=MyProject.Section1.A',
    	'http://localhost/JSPWiki/Wiki.jsp?page=MyProject.Section1.B',
    	'http://localhost/JSPWiki/Wiki.jsp?page=MyProject.Section2.A',
    	'http://localhost/JSPWiki/Wiki.jsp?page=MyProject.Section2.B'
	  ].each do |expected_url|
    	html.index(expected_url).should_not == -1
    end
  end

end