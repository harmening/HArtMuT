# HArtMuT (Head Artefact Model using Tripoles)
**Supplementary material to the scientific publication (currently in submission)**<br>
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
## [`HArtMuTmodels`](HArtMuTmodels)<br>
The final HArtMuT (BEM- and FEM-models) including cortical and artefactual sourcemodels, leadfields and labels.


## [`individualwarp`](individualwarp)<br>
Artefact model warping for individual head geometries.
<br>
<br>
<br>
<br>
<br>




### Citing HArtMuT
If you find HArtMuT useful for your research, please consider citing our related [paper](https://www.biorxiv.org/content/10.1101/2022.08.19.504507v1):
```
@article{anders2021software,
      author  = {Harmening, Nils and
                 Klug, Marius and
                 Gramann, Klaus and
                 Miklody, Daniel},
      title   = {HArtMuT - Modeling eye and muscle contributors in neuroelectric imaging},
      year    = {2022},
      doi     = {10.1101/2022.08.19.504507},
      journal = {bioRxiv}
}
```
