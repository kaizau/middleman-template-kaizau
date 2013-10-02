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
# Helper for generating a <span> if you're on the page, but an <a> otherwise
#
# Padrino doesn't wrap the false condition of `link_to :if => ...` in a <span>.
# This is a workaround to produce more styleable output.
#
def active_link(name, page, active = "active")
  if page?(page)
    "<span class='#{active}'>#{name}</span>"
  else
    link_to name, page
  end
end
