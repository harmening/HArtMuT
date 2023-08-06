# HArtMuT Atlas

Since the HArtMut parcellation atlas has been derived by using the [MIDA model](https://itis.swiss/virtual-population/regional-human-models/mida-model/), the IT'IS Foundation owns the rights to object against publishing the full HArtMuT atlas here with all the detailed tissue information. This parcellation atlas here therefore embodies only an anonymized version with the seperation between left eye, right eye, face muscles and neck muscles. The eye classes deliberately also include the eye and eyelid muscles, due to the common application of parcellation atlas in source localization.<br>
For more details on how this atlas has been derived, please refer to [Creation of an Anatomical Artefact Atlas Based on HArtMuT](https://doc.neuro.tu-berlin.de/bachelor/2022-BA-MoritzSteffin.pdf).<br>



## How to load HArtMuTs atlas in standard software toolboxes?
### Matlab
Integration into fieldtrip [[1]](#ref1): Download `hartmut.nii.gz` and `hartmut.csv` and place it into a seperate folder of your local fieldtrip installation (e.g. `fieldtrip/template/atlas/hartmut/`)
```matlab
hartmut_atlas  = ft_read_atlas('fieldtrip/template/atlas/hartmut/hartmut.nii.gz')
hartmut_mri    = ft_read_mri('fieldtrip/template/atlas/hartmut/hartmut.nii.gz')
cfg            = [];
cfg.roi        = coordinates; % Nx3 vector, coordinates of the POI
cfg.atlas      = hartmut_atlas;
cfg.output     = 'single';
labels         = ft_volumelookup(cfg, hartmut_mri);
```
### Python
Integration into [atlasreader](https://github.com/miykael/atlasreader) [[2]](#ref2): Download `hartmut.nii.gz` and `hartmut.csv` and place it as `atlas_hartmut.nii.gz` and `labels_hartmut.csv`, respectively, into your local atlasreader installation (e.g. `/usr/local/lib/python3.9/site-packages/atlasreader/data/atlases`)
```python
from atlasreader.atlasreader import read_atlas_peak
labels = [read_atlas_peak('hartmut', pos, prob_thresh=5) for pos in coordinates]
```


## References
<a id="ref1">[1]</a> Robert Oostenveld, Pascal Fries, Eric Maris, Jan-Mathijs Schoffelen. "FieldTrip: Open Source Software for Advanced Analysis of MEG, EEG, and Invasive Electrophysiological Data" *Computational Intelligence and Neuroscience*, (2011): **2011:156869**. [``doi.org/10.1155/2011/156869``](https://doi.org/10.1155/2011/156869). <br> 
<a id="ref2">[2]</a> Michael P. Notter, Dan Gale, Peer Herholz, Ross D. Markello, Marie-Laure Notter-Bielser, Kirstie Whitaker. "AtlasReader: A Python package to generate coordinate tables, region labels, and informative figures from statistical MRI images." *Journal of Open Source Software*, (2019): **4(34)**, 1257. [``doi.org/10.21105/joss.01257``](https://doi.org/10.21105/joss.01257).<br>
