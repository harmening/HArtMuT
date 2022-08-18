# Individual Warp
### Wanna use HArtMuTs artefactmodel for your own head?

Use our warping method to approximately project muscle and eye positions into indivual head shapes, since existing (nonlinear) warping methods so far only work reliably for cortical sources (sources located inside skull mesh).

## Prerequisites
- MRI scan (including the neck).
- Doing the segmentation of the indiviual MRI with [this automatic MRI segmentatoin routine](https://github.com/harmening/MRIsegmentation) is strongly recommended, since the warping algorithm only works for equal segmentation approximations/assumptions (regarding the especially the skull mesh).
- Put skull and (neck extended) scalp mesh into seperate folder and replace `Colin27` in `example.jl` by your own path to that folder.
- Install [julia](https://julialang.org/downloads/) and [python](https://www.python.org/downloads/).
- Install VTK (`pip install vtk`).
- Add its path, e.g. "/usr/local/lib/python2.7/site-packages/vtk/" (Mac) or "C:\Program Files\VTK 7.1.1\bin\Lib\site-packages\vtk" (Windows), to your PYTHONPATH. (Basically make sure that opening up a Python shell and writing `import vtk` works.)
- Find your computer's python.exe file, e.g. "/usr/local/bin/python2.7" (Mac) or "C:\Python27\python.exe" (Windows), and run the following two commands in Julia replacing the path below with your own and "\\" with "\\\\":
```
ENV["PYTHON"] = "C:\\Python27\\python.exe"
Pkg.build("PyCall")
```
- Make sure the following Julia code now works:
```
using PyCall
@pyimport vtk as vtk
```
<br>

## Start individualization algorithm
This small example script warps the artefacts from MNI space (NYhead) to Colin27. Specify your individual parameters like your own target head in `example.jl` and run
```
julia example.jl
```
The results are stored as `.mat` in your specified target folder (in this example as `Colin27/HArtMuT_Colin27.mat`).
