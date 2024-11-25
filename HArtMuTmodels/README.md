# HArtMuT models

## HArtMuT mix Colin27 small
`HArtMuT_mix_Colin27_small.mat`<br>
This BEM model is based on the anatomy of Colin27 [[1]](#ref1) and consists of cortical dipoles, muscular tripoles and ocular symmetric dipoles. This turned out to be the optimal model regarding source localization performance [[2]](#ref2).
<br>

## HArtMuT dipoles NYhead small
`HArtMuT_NYhead_small.mat`<br>
This FEM model is based on the [NYhead](https://www.parralab.org/nyhead/) [[3]](#ref3) and models cortical, muscular and ocular sources as dipoles. It has been tested in [SEEREGA](https://github.com/lrkrol/SEREEGA) [[4]](#ref4) by Laurens Krol.
<br>

## HArtMuT mix Colin27 sourcemodelgrid
`HArtMuT_mix_Colin27_sourcemodelgrid.mat`<br>
This BEM sourcemodelgrid is based on the anatomy of Colin27 [[1]](#ref1) and consists of cortical dipoles, muscular tripoles and ocular symmetric dipoles. This model does not follow any anatomically realistic source positions (e.g. MRI scan based) - it simply contains an equidistant grid through the full head and is thus well suited for linear source localization routines like [fieldtrips `ft_dipolefitting`](https://github.com/fieldtrip/fieldtrip/blob/master/ft_dipolefitting.m).
<br>

## How to load files?
### Matlab
```matlab
load('HArtMuT_mix_Colin27_small.mat');
```
### Python
```python
import scipy.io as sio
hartmut = sio.loadmat('HArtMuT_mix_Colin27_small.mat')['HArtMuT']
```
### Julia
```julia
using MAT
file = matopen('HArtMuT_mix_Colin27_small.mat');
hartmut = read(file, "HArtMuT");
close(file);
```


## References
<a id="ref1">[1]</a> Colin J. Holmes, Rick Hoge, Louis Collins, Roger Woods, Arthur W. Toga, Alan C. Evans. "Enhancement of MR images using registration for signal averaging" *Journal of computer assisted tomography*, (1998): **22**(2), 324 - 333. [``doi.org/10.1097/00004728-199803000-00032``](https://doi.org/10.1097/00004728-199803000-00032). <br> 
<!--- \cite{Holmes98} --->
<a id="ref2">[2]</a> Nils Harmening, Marius Klug, Klaus Gramann, Daniel Miklody. "HArtMuT - Modeling eye and muscle contributors in neuroelectric imaging" *BioRxiv*, (2022). [``doi.org/10.1101/2022.08.19.504507``](https://doi.org/10.1101/2022.08.19.504507).<br> 
<!--- \cite{Harmening2022}  --->
<a id="ref3">[3]</a> Yu Huang, Lucas C. Parra, Stefan Haufe. "The New York Head -- A precise standardized volume conductor model for EEG source localization and tES targeting" *NeuroImage*, (2016): **140**, 150 - 162. [``doi.org/10.1016/j.neuroimage.2015.12.019``](https://doi.org/10.1016/j.neuroimage.2015.12.019). <br> 
<!--- \cite{Huang16} --->
<a id="ref4">[4]</a> Laurens R. Krol, Juliane Pawlitzki, Fabien Lotte, Klaus Gramann, Thorsten O. Zander. "SEREEGA: Simulating Event-Related EEG Activity" *Journal of Neuroscience Methods*, (2018): **309**, 13 - 24. [``doi.org/10.1016/j.jneumeth.2018.08.001``](https://doi.org/10.1016/j.jneumeth.2018.08.001). <br> 
<!--- \cite{Krol2018} --->
