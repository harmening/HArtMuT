# HArtMuT (Head Artefact Modeul using Tripoles)
**Supplementary Scripts to the scientific publication (in submission)**
<br>
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.6393098.svg)](https://doi.org/10.5281/zenodo.6393098)
<br>
Electroencephalogram (EEG) and Magnetoencephalograhy (MEG) data are often
heavily polluted by artefacts stemming from eyes and muscles.
Neuroscientific researchers usually decrease their effect with artefact
cleaning methods operating in sensor space (e.g. filtering, subtracting signals
from additional eye or neck electrodes) or by offline removal of automatically
or even manually identified independent or principal components (ICs/PCs).
When source localization techniques are applied in the following data analysis,
the data is commonly cleaned from artefacts before.
However, this chronological procedure leads to distorted EEG time series due to
imperfect artefact reduction routines and introduces a bias into the subsequent
source localization.<br>
Therefore, we propose adding artefact sources to the head model in a similar
way, as it is done for cortex sources. Treating muscles and eyes as proper
contributors to EEG potentials allows, to identify, ignore or exclude them
automatically during the source localization process without distorting the
original EEG signals.<br>
In doing so, we created HArtMuT (Head ARTefact Model
Using Tripoles), a volume conduction head model with cortical dipole
sources enhanced by symmetric dipoles for the eyes as well as tripoles for face
and neck muscles. For more details, (here's)[https://doi.org/10.5281/zenodo.6393098]
the preprint to the scientific paper about myself. 
