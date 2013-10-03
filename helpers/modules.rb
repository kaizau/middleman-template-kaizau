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
    scripts.map! do |script|
      if script[0,2] == "//" || script[0,7] == "http://" || script[0,8] == "https://"
        # use as is
      elsif script[0] == "!"
        script = script[1..-1]
      elsif script == "jquery"
        script = development? ? asset_path(:js, "vendor/jquery.min") : "//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"
      else
        script = asset_path :js, script
      end

      "'#{script}'"
    end

    output = javascript_include_tag "vendor/modernizr.min"
    output << %Q|\n<script>\n  Modernizr.load([\n    #{scripts.join(",\n    ")}\n  ]);\n</script>|.html_safe
  else
    output = "<!--[if lt IE 9]><script src='//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.1/html5shiv.min.js'></script><![endif]-->".html_safe
    output << "<script>with(document.documentElement){className=className.replace(/\\bno-js\\b/,'js')}</script>".html_safe
  end
end
