const isAppleARM = Sys.isapple() && Sys.ARCH === :aarch64
if !isAppleARM
    using TikzPictures
end

function hfun_bar(vname)
    val = Meta.parse(vname[1])
    return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
    var = vname[1]
    return pagevar("index", var)
end

function lx_baz(com, _)
    # keep this first line
    brace_content = Franklin.content(com.braces[1]) # input string
    # do whatever you want here
    return uppercase(brace_content)
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
