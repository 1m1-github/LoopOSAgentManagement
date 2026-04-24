module LoopOSAgentManagement

export createagent, startagent, stopagent, rmagent

using LoopOSLearning: newpkg

const PROCESS = Dict{String,Base.Process}()

const FILE(name) = """
module $name
using LoopOSAgent
using LoopOSLogging # DEBUG
function (@main)(ARGS)
    LoopOS.awaken(@__FILE__)
end
end
"""
file(name) = joinpath(LoopOSLearning.JULIACODEPATH, name, "src", name * ".jl")

function createagent(;name, pkgs)
    newpkg(;
        name = name,
        pkgs = [
            "LoopOS",
            "LoopOSAgent",
            pkgs...,
            "LoopOSLogging", # DEBUG
        ],
    )    
    write(file(name), FILE(name))
    mkdir(name) && cd(name)
    startagent(name)
end
function startagent(name)
    cd(name) do
        PROCESS[name] = run(`julia --quiet --depwarn=error --threads auto $(file(name)) $name`)
    end
end
stopagent(name) = kill(PROCESS[name])
function rmagent(name)
    stopagent(name)
    run(`rm -rf $name`)
end

end
