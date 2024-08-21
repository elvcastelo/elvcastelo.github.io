<!--
Add here global page variables to use throughout your website.
-->
+++
author = "Emanuel Castelo"
mintoclevel = 2

# uncomment and adjust the following line if the expected base URL of your website is something like [www.thebase.com/yourproject/]
# please do read the docs on deployment to avoid common issues: https://franklinjl.org/workflow/deploy/#deploying_your_website
# prepath = "yourproject"

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "Emanuel Castelo"
website_descr = "Personal website of Emanuel Castelo"
website_url   = "https://elvcastelo.github.io/"
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\definition}[1]{
  @@definition
  **Definição**: #1
  @@
}
\newcommand{\proposition}[1]{
  @@proposition
  **Proposição**: #1
  @@
}
\newcommand{\nameddefinition}[2]{
  @@definition
  **Definição**: (_!#1_)
  #2
  @@
}
\newcommand{\example}[1]{
  @@example
  **Exemplo**: #1
  @@
}
\newcommand{\namedexample}[2]{
  @@example
  **Exemplo**: (_!#1_)
  #2
  @@
}
\newcommand{\corollary}[1]{
  @@corollary
    **Corolário**: #1
  @@
}
