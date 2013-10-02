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
