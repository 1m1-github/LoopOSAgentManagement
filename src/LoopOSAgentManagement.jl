module LoopOSAgentManagement

export startagent, stopagent

# using Pkg
# import Main.Revise
# import Main.State

const LOOPOSPKG = "https://github.com/1m1-github/LoopOS.git"
const PROCESS = Dict{String,Base.Process}

function creatagent(name, pkgs, files)
    # newpkg(name, pkgs, files)
    # isdir(name) && error("$name already exists")
    # Pkg.generate(name)
    # cd(name) do
    #     Pkg.activate(".")
    #     run(`mkdir long`)
    #     Pkg.add(LOOPOSPKG)
    #     for pkg = pkgs Pkg.add(pkg) end
    # end
    # Pkg.activate(".")
end

function startagent(name)
    PROCESS[name] = run(`julia --quiet --depwarn=error --threads auto main.jl $name`)
end

stopagent(name) = kill(PROCESS[name])

function rmagent(name)
    stopagent(name)
    run(`rm -rf $name`)
end

end
