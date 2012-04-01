require 'pp'

# Project Dir
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

# Compass
compass_config do |c|
  c.output_style = :expanded
  c.line_comments = false
end

# Haml
activate :automatic_image_sizes
helpers do
  def debug obj
    "\n<pre>\n\n#{h obj.pretty_inspect}\n</pre>\n\n"
  end

  def dev_header
    if environment == :development
      "<!--\n"\
      "  DEVELOPMENT SITE\n"\
      "  Last Updated: #{DateTime.now.strftime('%b %d, %Y - %H:%M:%S')}\n"\
      "-->\n"\
      "<meta name='robots' content='noindex, nofollow' />\n"
    end
  end
end

# Build
configure :build do
  compass_config {|c| c.output_style = :compressed}

  activate :relative_assets
  #activate :minify_javascript
  #activate :cache_buster

  ignore '/css/lib/bourbon/lib/bourbon/sass_extensions/functions.rb'
  ignore '/css/lib/bourbon/lib/bourbon/sass_extensions/functions/compact.rb'
  ignore '/css/lib/bourbon/lib/bourbon/sass_extensions.rb'
  ignore '/css/lib/bourbon/lib/bourbon.rb'
end
