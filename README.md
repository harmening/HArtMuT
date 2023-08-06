# HArtMuT (Head Artefact Model using Tripoles)
**Supplementary material to the scientific publication "HArtMuT - Modeling eye and muscle contributors in neuroelectric imaging" in Journal of Neural Engineering 19(6), 2022.**<br>
<img align="right" width="200" src="images/HArtMuT.png">
### Who is this HArtMuT?
Correctly localizing and identifying ICA patterns as brain or non-brain sources relies on head models 
that so far only take brain sources into account.<br>
We developed the Head Artefact Model using Tripoles (HArtMuT), a volume
conduction head model, that includes, besides brain sources, eyes and muscles
that can be modeled as single dipoles, symmetrical dipoles, and tripoles.<br>
We compared HArtMuT with the EEGLAB standard head model on their localization
accuracy and residual variance (RV) using firstly, a Finite Element Model (FEM)
as ground truth, and secondly, real-world data of mobile participants, and
found that HArtMuT improves localization for all sources, especially
non-brain.<br>

For more details, feel free to visit [https://www.hartmut.berlin](https://hartmut.neuro.tu-berlin.de/).

### What can I find here?
## [`artefactatlas`](artefactatlas)<br>
A HArtMuT parcellation atlas for the purpose of labeling within source localization routines.


## [`HArtMuTmodels`](HArtMuTmodels)<br>
The final HArtMuT (BEM- and FEM-models) including cortical and artefactual sourcemodels, leadfields and labels.


## [`individualwarp`](individualwarp)<br>
Artefact model warping for individual head geometries.
<br>
<br>
<br>
<br>
<br>



### Integration
We are currently working on integrating HArtMuT into standard neuoscience pipelines ([OpenMEEG](https://github.com/openmeeg/openmeeg/pull/603), [FieldTrip toolbox](https://github.com/fieldtrip/fieldtrip/issues/2252), DIPFIT (EEGLAB plug-in) planned). Details will follow soon.<br><br>


### Citing HArtMuT
If you find HArtMuT useful for your research, please consider citing our related [paper](https://iopscience.iop.org/article/10.1088/1741-2552/aca8ce):
```
@article{Harmening_2022,
      author  = {Harmening, Nils and
                 Klug, Marius and
                 Gramann, Klaus and
                 Miklody, Daniel},
      title   = {HArtMuT - Modeling eye and muscle contributors in neuroelectric imaging},
      year    = {2022},
      doi     = {10.1088/1741-2552/aca8ce},
      journal = {Journal of Neural Engineering}
      volume  = {19},
      number  = {6},
      pages   = {066041},
}
```
