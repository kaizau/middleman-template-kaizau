# ============================================================================ #
# Middleman Config
#
# More settings:
# http://rubydoc.info/github/middleman/middleman/Middleman/Application
# http://rubydoc.info/github/middleman/middleman/Middleman/Extensions
# ============================================================================ #

require 'sass-globbing'
require 'lib/helpers'
helpers CustomHelpers

# Middleman
set :layout, 'application'
activate :livereload if development?
activate :directory_indexes
activate :sprockets
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true,
               :autolink => true,
               :superscript => true,
               :with_toc_data => true,
               :smartypants => true

# Compass
compass_config do |c|
  c.output_style = :expanded
end

# Build
configure :build do
  compass_config {|c| c.output_style = :compressed }
  activate :minify_javascript, :ignore => /vendor\/*/
  activate :asset_hash
  #activate :asset_host
  #set :asset_host do
  #  '//EXAMPLE.cloudfront.net'
  #end
end
