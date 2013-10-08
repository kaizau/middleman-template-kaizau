# ============================================================================ #
# Middleman Config
#
# More settings:
# http://rubydoc.info/github/middleman/middleman/Middleman/Application
# http://rubydoc.info/github/middleman/middleman/Middleman/Extensions
# ============================================================================ #

require "sass-globbing"
require "mini_magick"
require "fileutils"

# Project
set :layout, "sticky"
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"
set :fonts_dir, "assets/fonts"
set :partials_dir, "shared"

# Under the Hood
activate :livereload, :grace_period => 1 if development?
activate :directory_indexes
activate :sprockets
activate :syntax, :line_numbers => true
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true,
               :autolink => true,
               :superscript => true,
               :with_toc_data => true,
               :smartypants => true

# Build
configure :build do
  compass_config { |c| c.output_style = :compressed }
  activate :minify_javascript, :ignore => /vendor\/*/
  activate :asset_hash
  #activate :asset_host, :host => "//EXAMPLE.cloudfront.net"
end

# Compass
compass_config do |c| 
  c.output_style = :expanded

  c.on_sprite_saved do |sprite|
    if is_jpeg_sprite? sprite
      cleanup_old_jpegs sprite
      convert_to_jpeg sprite
    end
  end
end

before do
  # Does manipulating the sitemap also manipulate CSS output?
  # If so, let's swap jpeg sprites here. Alternatively, it could
  # be a build-only process.
  puts ">> before"
  puts config.images_dir
  puts config.css_dir
end

def is_jpeg_sprite?(sprite)
  !! sprite.match(/\/(jpe?g(-|_)sprites|sprites(-|_)jpe?g)\//) ||
    !! sprite.match(/(-|_)jpe?g-s/)
end

def cleanup_old_jpegs(png)
  root = png.match(/^(.+-s).+\.png$/)[1]
  root = root.sub(config[:source_dir].to_s + "/", "")
  Dir["#{root}*.jpg"].each { |file| FileUtils.rm(file) }
end

def convert_to_jpeg(filename)
  output = filename.chomp("png") + "jpg"
  image = MiniMagick::Image.open filename
  image.combine_options do |c|
    c.background "#ffffff"
    c.alpha "remove"
  end
  image.format "jpg"
  image.write output
  output
end
