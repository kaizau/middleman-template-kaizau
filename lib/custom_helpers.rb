require "pp"

module CustomHelpers

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
    return unless development?
    %Q|<!--
  DEVELOPMENT SITE
  Last Updated: #{DateTime.now.strftime("%b %d, %Y - %H:%M:%S")}
  -->
  <meta name='robots' content='noindex, nofollow' />|.html_safe
  end

  ##
  # Helper for determining the current page template
  #
  # Accepts a symbol or string and matches even when directory_indexes is on.
  #
  def page?(page)
    page = page.to_s
    page = "index" if page == "/"
    page[0] = "" if page[0] == "/"
    request.path == page ||
      request.path == "#{page}.html" ||
      request.path == "#{page.chomp(".html")}/index.html"
  end

  def index?
    page? :index
  end

  ##
  # Helper for nav links 
  #
  # Padrino doesn't wrap the false condition of `link_to :if => ...` in a tag,
  # making styling a pain. This helper generates a <span> if you're on the page, but an <a> otherwise.
  #
  def active_link(name, page, active = "active")
    if page?(page)
      content_tag :span, name, :class => active
    else
      link_to name, page
    end
  end

  ##
  # Code blocks with correct indentation
  #
  # http://stackoverflow.com/questions/14792490/middleman-haml-with-github-style-fenced-code-blocks
  # Still requires the :plain filter, but better than triple nesting each time
  #
  def code_block(syntax, &plaintext)
    preserve { code(syntax.to_s, &plaintext) }
  end

  ##
  # Outputs modernizr script tags, with appropriate jquery path
  #
  # Scripts should be added as a page variable (array).
  # External paths and paths prefixed with "!" are not altered.
  # jQuery CDN path is automatically added on production for "jquery".
  #
  def modernizr_scripts
    scripts = current_page.data.javascripts || data.global.javascripts

    if scripts.is_a?(Array)
      scripts = scripts.map do |script|
        if script[0,2] == "//" || script[0,7] == "http://" || script[0,8] == "https://"
          # use as is
        elsif script[0] == "!"
          script = script[1..-1]
        elsif script == "jquery"
          script = development? ? asset_path(:js, "vendor/jquery") : "//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"
        else
          script = asset_path :js, script
        end
        "'#{script}'"
      end

      output = javascript_include_tag "vendor/modernizr"
      output << %Q|\n<script>\n  Modernizr.load([\n    #{scripts.join(",\n    ")}\n  ]);\n</script>|.html_safe
    else
      javascript_include_tag "vendor/modernizr"
    end
  end

end
