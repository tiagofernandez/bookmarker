require 'erb'

def main
  # Read options
  options = eval(File.open('lib/options.rb') { |f| f.read } )
  
  # Generate HTML
  bookmarker = Bookmarker.new(options)
  html = bookmarker.generate_html

  # Write output file
  output_dir = 'output'
  output_file = "#{output_dir}/bookmarks_#{options[:key]}_#{Time.new.strftime("%Y%m%d")}.html"
  Dir.mkdir(output_dir) if not File.exist?(output_dir)
  File.open(output_file, 'w') { |f| f.write(html) }
end

class Bookmarker
  
  def initialize(options)
    @base_url   = options[:base_url]
    @path       = options[:path]
    @key        = options[:key]
    @separator  = options[:separator]
  end

  def generate_html(key=@key)
    entries = read_entries(key)
    template = %{<!DOCTYPE NETSCAPE-Bookmark-file-1>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
    <TITLE>Bookmarks</TITLE>
    <H1>Bookmarks</H1>
    <DL><p>
      <DT><H3><%= key %></H3>
      <DL><p>
          <DT><A HREF="<%= @base_url %><%= key %>"><%= key %></A>
          <% entries.delete(key) %>
          <% entries.keys.sort.each do |section| %>
          <DT><H3><%= section %></H3>
          <DL><p>
            <% entries[section].each do |link| %>
            <DT><A HREF="<%= @base_url %><%= link %>"><%= link %></A>
            <% end %>
          </DL><p>
          <% end %>
        </DL><p>
      </DL><p>
    </DL><p>}.gsub(/^    /, '')
    return ERB.new(template).result(binding)
  end

  private

  def read_entries(key)
    entries = {}
    files = Dir["#{@path}/#{key}*.*"]
    files.each do |filepath|
      filename = get_filename(filepath)
      section = get_section(filename)
      add_entry(entries, section, filename)
    end
    return entries
  end

  def add_entry(entries, section, filename)
    if entries.has_key?(section)
      entries[section] << filename
    else
      entries[section] = []
      add_entry(entries, section, filename)
    end
  end

  def get_section(filename)
    tokens = filename.split(@separator)
    if tokens.size == 1
      return tokens[0]
    else
      return tokens[1]
    end
  end

  def get_filename(filepath)
    return File.basename(filepath, File.extname(filepath))
  end

end

#--------------------------
main