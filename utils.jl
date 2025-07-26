const isAppleARM = Sys.isapple() && Sys.ARCH === :aarch64
if !isAppleARM
    using TikzPictures
end

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

if !isAppleARM
    # so we don't have to install LaTeX on CI
    tikzUseTectonic(true)

    function env_tikzpic(e, _)
        content = strip(Franklin.content(e))
        name = strip(Franklin.content(e.braces[1]))
        # save SVG at __site/assets/[path/to/file]/$name.svg
        rpath = joinpath("assets", splitext(Franklin.locvar(:fd_rpath))[1], "$name.svg")
        outpath = joinpath(Franklin.path(:site), rpath)
        println(outpath)
        # if the directory doesn't exist, create it
        outdir = dirname(outpath)
        isdir(outdir) || mkpath(outdir)
        # save the file and show it
        save(SVG(outpath), TikzPicture(content))
        return "\\fig{/$(Franklin.unixify(rpath))}"
    end

else
    env_tikzpic(_, _) = ""
end
