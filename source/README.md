## Pages

### Haml Cheatsheet

```haml
-# DATA
= data.app.global_var
= current_page.data.local_var
= local_var

-# CONTENT
- content_for :meta do ... end
= link_to "The Link", "the/link/path", :class => "nifty"
= active_link "The Link", "the/link/path"
= image_tag "puppies.jpg", :alt => "Fido and Bella!"
= form_tag "/update", :method => "POST" do ... end
= code_block :ruby do ... end

-# PARTIALS
= partial :header
= partial :header, :locals => {:foo => "bar"}

-# LOREM
= lorem.words 10
= lorem.paragraph
= lorem.image "300x400"

-# INTROSPECTION
- development?
- build?
- index?
- page? :page
```

See also:

- <http://middlemanapp.com/templates/helpers/>
- <http://www.padrinorb.com/api/Padrino/Helpers.html>
