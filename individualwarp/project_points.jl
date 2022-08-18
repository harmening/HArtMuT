using LinearAlgebra
include("caster.jl")

function project_points(pos, midacaster, targetcaster, mean_pnt, mean_pnt_target=nothing, target_pos=nothing)
    # Algorithm:
    # 1. For every source point find intersection of line from mean point through
    # source point with source skull and scalp mesh.
    # 2. Calculate the two distances from the two intersections with the source point.
    # 3. Take the same line in target head and find intersections with skull and scalp mesh.
    # 5. Reproduce the distance ratio of source head into target head to find
    # the target point on line corresponding to source line.
    
    if mean_pnt_target == nothing
        mean_pnt_target = mean_pnt    
    end
    
    new_pos = zeros(size(pos))
    for ii in 1:size(pos)[1]
        p = pos[ii, :]
        proj = p .+1000*(p .- mean_pnt) 

        # Source
        mida_intersect = Dict()
        for shell in ["skull", "scalp"]
            poslst = castRay(midacaster[shell], mean_pnt, proj)
            if length(poslst) == 1
                intersect = poslst[1]
            elseif length(poslst) > 1
                # take instersection, that is close to original point  
                for iii in 1:size(poslst)[1]
                    intersect = poslst[iii,:]
                    if iii == 0
                        min_idx, min_dist = 0, norm(p - intersect)
                    else
                        if norm(p - intersect) < min_dist
                            min_idx, min_dist = iii, norm(p - intersect)
                        end
                    end
                end
                intersect = poslst[min_idx]
            else
                println("No intersection of point "*string(ii)*" with Source "*shell)
                min_idx, min_dist = shortest_dist(p, pos)   ### NOT VERY GOOD
                intersect = pos[min_idx,:]
            end
            mida_intersect[shell] = intersect
        end
        old_p_skull_dist = norm(p .- mida_intersect["skull"]) 
        @assert old_p_skull_dist > 0
        old_p_scalp_dist = norm(mida_intersect["scalp"].-p)
        @assert old_p_scalp_dist > 0
        ## Strangely the following two lines are not equal!!???!
        #old_skull_scalp_dist = norm(mida_intersect['scalp'] - mida_intersect['skull'])
        old_skull_scalp_dist = old_p_scalp_dist + old_p_skull_dist
        @assert old_skull_scalp_dist > 0
        old_p_scalp_dist /= old_skull_scalp_dist
        old_p_skull_dist /= old_skull_scalp_dist
        
        # TARGET
        target_intersect = Dict()
        for shell in ["skull", "scalp"]
            poslst = castRay(targetcaster[shell], mean_pnt, proj)
            if length(poslst) == 1
                intersect = poslst[1]
            elseif length(poslst) > 1
                # take instersection, that is close to original point  
                for (iii, intersect) in enumerate(poslst)
                    if iii == 0
                        min_idx, min_dist = 0, norm(p - intersect)
                    else
                        if norm(p - intersect) < min_dist
                            min_idx, min_dist = iii, norm(p - intersect)
                        end
                    end
                end
                intersect = poslst[min_idx]
            else
                println("No intersection of point "*string(ii)*" with target "*shell)
                min_idx, min_dist = shortest_dist(p, pos)   ### NOT VERY GOOD
                intersect = pos[min_idx,:]
            end
            target_intersect[shell] = intersect
        end
        new_start = target_intersect["skull"]   
        new_dir = target_intersect["scalp"] - target_intersect["skull"]    
        #new_dist = norm(new_dir)
        new_p1 = new_start + (new_dir * old_p_skull_dist) 
        new_p2 = target_intersect["scalp"]  - (new_dir * old_p_scalp_dist)
        for iii in 1:3
            @assert round(new_p1[iii] - new_p2[iii], digits=5) == 0
        end
        new_p = [(new_p1[iii]+new_p2[iii])/2 for iii in 1:3]
        new_pos[ii, :] = new_p
    end
    #new_pos = reshape(new_pos, :, 3)
    return new_pos
end






function shortest_dist(vert_pos, list_of_pos)
    min_idx, min_dist = 1, norm(list_of_pos[1] .- vert_pos)
    for c in 1:size(list_of_pos)[1]
        pos = list_of_pos[c,:]
        dist = norm(pos .- vert_pos)
        if dist < min_dist
            min_dist = dist
            min_idx = c
        end
    end
    return min_idx, min_dist
end

