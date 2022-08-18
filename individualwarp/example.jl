using MAT # matopen
using FileIO
import LinearAlgebra
include("caster.jl")
include("project_points.jl")

function mesh2pos(mesh)
    triangles = [[tri[ii] for ii in 1:3] for tri in mesh]
    pos = zeros(Float32, size(triangles)[1]*3, 3)
    for (i, tri) in enumerate(mesh)
        for ii in 1:3
            for jj in 1:3
              pos[(i-1)*3+ii,jj] = tri[ii][jj]
            end
        end
    end
    pos = unique(pos, dims=1)
    return pos
end



## Heads

# Source Head
#filename_scalp = "./NYhead/scalp_approx_acpc_mm.stl"
#filename_skull = "./NYhead/skull_approx_acpc.stl"
#mni = Dict("scalp" => stlcaster(filename_scalp),
#            "skull" => stlcaster(filename_skull))
#mesh = load(filename_skull)
#pos = mesh2pos(mesh);
#mean_pnt = (sum(pos, dims=1)/size(pos)[1])[1,:]
filename_scalp = "./NYhead/scalp.tri"
filename_skull = "./NYhead/skull.tri"
mni = Dict("scalp" => tricaster(filename_scalp),
            "skull" => tricaster(filename_skull))
pos, tri = load_tri(filename_skull)
mean_pnt = (sum(pos, dims=1)/size(pos)[1])[1,:][1]


#pos, tris = load_tri("./NYhead/scalp_approx_acpc_mm.tri")
#triangles = [[pos[i] for i in tri] for tri in tris]



# Target Head
#filename_scalp = "./Colin27/extended_scalp_1922.stl"
#filename_skull = "./Colin27/skull.stl"
#colin = Dict("scalp" => stlcaster(filename_scalp),
#             "skull" => stlcaster(filename_skull))
filename_scalp = "./Colin27/extended_scalp.tri"
filename_skull = "./Colin27/skull.tri"
colin = Dict("scalp" => tricaster(filename_scalp),
             "skull" => tricaster(filename_skull))

fname = "./NYhead/artefactmodel_small.mat"
file = matopen(fname)
artefactmodel = read(file, "artefactmodel_small")
close(file)

sources = artefactmodel["pos"]
new_sources = project_points(sources, mni, colin, mean_pnt)

## Save
individual_artefactmodel = Dict("pos" => new_sources,
                               "orientation" => artefactmodel["orientation"],
                               "labels" => artefactmodel["tissue"],
                               "unit" => artefactmodel["unit"])
fname = "./Colin27/HArtMuT_Colin27.mat"
file = matopen(fname, "w")
write(file, "HArtMuT", individual_artefactmodel)
close(file)
