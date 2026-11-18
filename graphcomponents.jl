# test arrays
V1 = [1,2,3,4,5,6,7,8]
E1 = [(1,2),(2,3),(1,3),(4,5),(5,6),(5,7),(6,7),(7,8)]

V2 = [1,2,3,4,5]
E2 = [(1,2),(1,3),(1,4),(1,5)]

V3 = [1,2,3,4,5,6,7,8,9,10,11,12]
E3 = [(1,2),(2,3),(3,4),(4,1),(2,4),
      (5,6),(5,7),(6,8),(7,8),(8,9),
      (10,11),(11,12)]

V4 = [1,2,3,4,5,6,7,8,9,10]

E4 = [(1,2),(1,3),(2,4),(2,5),
      (3,6),(3,7),(4,8),(5,8),
      (6,9),(7,9),(8,10),(9,10)]

function array_to_neigh_dict(V, E)
    dict = Dict{Int, Vector{Int}}() # keys: vertices, values: arrays of vertices
    for i in V
        dict[i] = []
    end
    for edge in E # (i,j)
        vertice = edge[1]
        neigh = edge[2]
        push!(dict[vertice], neigh)
        push!(dict[neigh], vertice)
    end
    return dict
end


function findcomponents(V, E)
    neighs = array_to_neigh_dict(V,E)
    stack = Int[] # elements waiting to be searched
    searched = Int[] # track which vertices have already been searched
    components = Vector{Vector{Int}}() # array of arrays
    
    for u in V
        if !(u in searched)
            component = Int[] # start a new component
            push!(stack, u)
            push!(searched, u) # mark it as searched

            while !isempty(stack)
                curr = pop!(stack)
                push!(component, curr) # add to the component
                
                for v in neighs[curr]
                    if !(v in searched)
                        push!(stack, v)
                        push!(searched, v) # mark it as already added to stack, so we dont get the same element on the stach multiple times
                    end
                end    
            end

            push!(components, component) # add the whole component to the components list
        end
    end

    return components
end

testdict = findcomponents(V3, E3)
println(testdict)

testdict = findcomponents(V4, E4)
println(testdict)