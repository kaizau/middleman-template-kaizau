require "pp"

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
