import Pkg
Pkg.add("PyCall")
#pushfirst!(PyVector(pyimport("sys")."path"), @__DIR__)
#ENV["PYTHON"] = "/usr/local/bin/python3.7
#Pkg.build("PyCall")  
using PyCall
@pyimport vtk as vtk


# Create a new 'rayCaster' with the mesh loaded from the .stl file
function stlcaster(filenameSTL)
  return caster(load_stl(filenameSTL))
end

function load_stl(filenameSTL)
    readerSTL = vtk.vtkSTLReader()
    readerSTL.SetFileName(filenameSTL)  # set the .stl filename in the reader
    readerSTL.Update()  # 'update' the reader i.e. read the .stl file

    polydata = readerSTL.GetOutput()
    # If there are no points in 'vtkPolyData' something went wrong 
    if polydata.GetNumberOfPoints() == 0
        error("No point data could be loaded from " * filenameSTL)
    end
    mesh = polydata
    return mesh
end

function caster(mesh)
    caster = vtk.vtkOBBTree() 
    caster.SetDataSet(mesh)
    caster.BuildLocator()
    return caster
end


function tricaster(filenameTRI)
  return caster(create_pointcloud_polydata(load_tri(filenameTRI)))
end


function load_tri(fname_in)
    lines = readlines(fname_in)
    n_nodes = parse(Int,lines[1][3:end])
    n_tris = parse(Int,split(lines[n_nodes + 2], " ")[end])
    n_items = length(split(lines[2]))
    if n_items in [3, 6]
        inds = 1:3
    else
        error("unimplemented")
    end
    pos = [[parse(Float64, v) for v in split(l)[inds]] for l in lines[2:n_nodes + 1]]
    tris = [[parse(Int, t)+1 for t in split(l)[inds]] for l in lines[n_nodes+3:n_nodes+2+n_tris]]
    return pos, tris
end

function write_stl(polydata, fname_in)
    writer = vtk.vtkSTLWriter()
    writer.SetFileTypeToASCII()
    writer.SetFileName(fname_in)
    writer.SetInputData(polydata)
    writer.Write()
    return
end

function create_pointcloud_polydata(bnd)
    pos, tri = bnd
    polydata = vtk.vtkPolyData()
    # feed in pos
    Points = vtk.vtkPoints()
    Points.SetNumberOfPoints(size(pos)[1])
    for i = 1:size(pos)[1]
        Points.SetPoint(i-1, pos[i])
    end
    polydata.SetPoints(Points)

    # feed in tri
    Triangles = vtk.vtkCellArray()
    for item in tri
        Triangle = vtk.vtkTriangle()
        Triangle.GetPointIds().SetId(0,item[1]-1)
        Triangle.GetPointIds().SetId(1,item[2]-1)
        Triangle.GetPointIds().SetId(2,item[3]-1)
        Triangles.InsertNextCell(Triangle)
		end
    polydata.SetPolys(Triangles)

		return polydata
end


function castRay(caster, pointRaySource, pointRayTarget)
    #create a 'vtkPoints' object to store the intersection points
    pointsVTKintersection = vtk.vtkPoints()

    #perform ray-casting (intersect a line with the mesh)
    code = caster.IntersectWithLine(pointRaySource,
                                    pointRayTarget,
                                    pointsVTKintersection, nothing)

    # Interpret the 'code'. If "0" is returned then no intersections points
    # were found so return an empty list
    if code == 0
        println("No intersection points found for 'pointRaySource': " * string(pointRaySource) * " and 'pointRayTarget': " * string(pointRayTarget))
        return []
    # If code == -1 then 'pointRaySource' lies outside the surface
    elseif code == -1
        #println("The point 'pointRaySource': " * string(pointRaySource) * "lies inside the surface")
        code = caster.IntersectWithLine(pointRayTarget,
                                        pointRaySource,
                                        pointsVTKintersection, nothing)
    end
    #get the actual data of the intersection points (the point tuples)
    pointsVTKIntersectionData = pointsVTKintersection.GetData()
    
    pointsIntersection = [pointsVTKIntersectionData[idx,:] for idx in size(pointsVTKIntersectionData)[1]]
                          
    
    """ 
    #get the number of tuples
    noPointsVTKIntersection = pointsVTKIntersectionData.GetNumberOfTuples()

    #create an empty list that will contain all list objects
    pointsIntersection = []

    # Convert the intersection points to a list of list objects.
    pointsIntersection = [pointsVTKIntersectionData.GetTuple3(idx) for idx in 1:noPointsVTKIntersection]

    #return the list of list objects
    """ 
    return pointsIntersection
end 

