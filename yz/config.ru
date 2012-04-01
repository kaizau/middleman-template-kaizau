require 'rubygems'
require 'bundler/setup'
Bundler.require(:rack)

ENV['RACK_ENV'] ||= 'production'
ENV['RESTRICTED'] ||= 'production'

# Basic Password Protection
if ENV['RESTRICTED'] == ENV['RACK_ENV'] && ENV['AUTHORIZED']
  users = eval(ENV['AUTHORIZED'])
  use Rack::Auth::Basic, "Please log in to view this page." do |u, p|
    users[u] == p
  end
end

# Rewrites
use Rack::Rewrite do
  # no www
  if ENV['RACK_ENV'] == 'production' && ENV['URL']
    r301 %r{.*}, "http://#{ENV['URL']}$&", :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] != ENV['URL']
    }
  end

  r301 %r{^/index/?$}, '/'                  # redirect index
  r301 %r{^/(?!.+(/|\..+)$)(.+)}, '/$2/'    # redirect all to trailing slash
  rewrite %r{^/(?=.+/$)(.+)/$}, '/$1.html'  # rewrite slash to html
end

# Static Cache  
if ENV['RACK_ENV'] = 'production'
  use Rack::StaticCache,
    :urls => ['/js', '/img'],
    :root => 'build'
end

# TryStatic
use Rack::TryStatic,
  :root => 'build',
  :urls => %w[/],
  :try => ['.html', 'index.html', '/index.html']

# 404
run lambda { |env|
  [
    404,
    {'Content-Type' => 'text/html'},
    ['<div style="color:#ccc;text-align:center;"><p style="font-size:200px;margin-bottom:0;padding-top:100px;">:(</p><h1>404</h1></div>']
    # File.open('build/404.html', File::RDONLY)
  ]
}