module ApplicationHelpers

  def partial file, locals = data.page
    render_partial('partials/' + file, :locals => locals)
  end

  def debug obj
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
