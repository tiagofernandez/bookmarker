# Bookmarker

Bookmarker is an utility for generating bookmarks from Wikis. The tool was tested
with JSPWiki, but it should work fine for any other text-based Wiki. The output is
an HTML file that can be imported by (descent) browsers, like Chrome and Firefox.


## Setup

		gem install rake
		gem install rspec (optional)
		gem install rcov (optional)


## Usage

All you need to do is edit the file lib/options.rb and set the Hash values according
to the Wiki you are targeting. Below a brief description:

* base_url: The common URL for the Wiki pages.
* path: The full path to the content (text files).
* key: The common identifier for the pages to import, usually the project name.
* separator: The character used to distinguish sections, usually a dot.

Once you have defined the options, go back to the Terminal and enter the command:

		rake run

The bookmark file should have be written to output/<key>.html. Now go ahead and
import it into your browser. Enjoy!


## Author

Tiago Fernandez (2011) | [Twitter][t]

[t]: http://twitter.com/tiagofernandez