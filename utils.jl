function hfun_blogposts()
    list = readdir("blog")
    filter!(f -> endswith(f, ".md"), list)
    dates = [stat(joinpath("blog", f)).mtime |> unix2datetime for f in list]
    io = IOBuffer()

    for i in eachindex(list)
        content = readlines(joinpath("blog", list[i]))
        ert = ceil(Int, length(content) / 30)
        fi = "/blog/" * splitext(list[i])[1] * "/"
        title = Franklin.hfun_fill(["title", fi[2:end-1]])
        description = Franklin.hfun_fill(["description", fi[2:end-1]])
        date = Franklin.hfun_fill(["date", fi[2:end-1]])
        category = Franklin.hfun_fill(["category", fi[2:end-1]])

        write(
            io,
            """<section>
      <article class=\"blogpost\">
      <h2>$(title)</h2>
      <p class="blogpost_meta">Publicado em $(date) | $(category) · $(ert) minutos de leitura</p>
      <p>$(description)</p>
      <a href=$(fi) class="blogpost_readmore">Ler mais</a>
      <hr />
      </article>
  </section>"""
        )
    end

    return String(take!(io))
end