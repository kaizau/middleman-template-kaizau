require 'pp'

module CustomHelpers
  def partial(file, locals = data.page)
    render_partial('partials/' + file, :locals => locals)
  end

  def page?(page)
    request.path == page + '.html' || request.path == '/' + page + '.html' || request.path == page + '/index.html'
  end

  def index?
    page? 'index'
  end

  def nav_link(name, page, active = 'active')
    page = 'index' if page == '/'
    if page?(page)
      "<span class='#{active}'>#{name}</span>"
    else
      link_to name, page
    end
  end

  def debug(obj)
    "\n<pre>\n\n#{h obj.pretty_inspect}\n</pre>\n\n" if development?
  end

  def dev_header
    if development?
      "<!--\n"\
      "  DEVELOPMENT SITE\n"\
      "  Last Updated: #{DateTime.now.strftime('%b %d, %Y - %H:%M:%S')}\n"\
      "-->\n"\
      "<meta name='robots' content='noindex, nofollow' />\n"
    end
  end
end
