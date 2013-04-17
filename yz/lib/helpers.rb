require 'pp'

module CustomHelpers

  ##
  # Shortcut to /source/partials
  #
  def partial(file, locals = data.page)
    render_partial('partials/' + file, :locals => locals)
  end

  ##
  # Helper for determining the page you're on
  #
  def page?(page)
    page = 'index' if page == '/'
    request.path == page + '.html' || request.path == '/' + page + '.html' || request.path == page + '/index.html'
  end

  def index?
    page? 'index'
  end

  ##
  # Helper for generating a <span> if you're on the page, but an <a> otherwise
  # 
  # Padrino doesn't wrap the false condition of `link_to :if => ...` in a <span>. 
  # This is a workaround to produce more styleable output.
  # 
  def active_link(name, page, active = 'active')
    if page?(page)
      "<span class='#{active}'>#{name}</span>"
    else
      link_to name, page
    end
  end

  ##
  # Quick and dirty variable inspection
  #
  def debug(obj)
    "\n<pre>\n\n#{h obj.pretty_inspect}\n</pre>\n\n" if development?
  end

  ##
  # Never forget your development meta tags again 
  #
  def dev_header
    if development?
%Q|<!--
  DEVELOPMENT SITE
  Last Updated: #{DateTime.now.strftime('%b %d, %Y - %H:%M:%S')}
-->
<meta name='robots' content='noindex, nofollow' />|
    end
  end

  ##
  # Outputs modernizr script tags, with appropriate jquery path
  #
  # Scripts should be added as a page variable (array). 
  # External paths and paths prefixed with '!' are not altered.
  # jQuery CDN path is automatically added on production for 'jquery'.
  #
  def modernizr_scripts
    if data.page.javascripts.is_a?(Array)
      jquery = (! development?) ? '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js' : asset_path(:js, 'vendor/jquery.min')
      scripts = data.page.javascripts.map do |script| 
        if script[0,2] == '//' || script[0,7] == 'http://' || script[0,8] == 'https://'
          # nothing
        elsif script[0] == '!'
          script = script[1..-1]
        elsif script == 'jquery'
          script = jquery
        else
          script = asset_path :js, script
        end

        "'#{script}'"
      end

      output = javascript_include_tag 'vendor/modernizr.min'
      output << %Q|\n<script>\n  Modernizr.load([\n    #{scripts.join(",\n    ")}\n  ]);\n</script>|
    else
      # No Modernizr means HTML5 elements still need to init'ing in old IE
%q|<!--[if lt IE 9]>
  <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.1/html5shiv.min.js"></script>
<![endif]-->|
    end
  end

  ##
  # Outputs the basic GA async code
  #
  # ID should be set as an app variable.
  #
  def google_analytics
    if data.app.google_analytics
%Q|<script>
  var _gaq=[['_setAccount','#{data.app.google_analytics}'],['_trackPageview']];
  (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
  g.src='//www.google-analytics.com/ga.js';
  s.parentNode.insertBefore(g,s)}(document,'script'));
</script>|
    end
  end

end
