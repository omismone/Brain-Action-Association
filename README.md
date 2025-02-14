# Identification of brain areas associated with the execution of an action

## Abstract

This study investigates the identification of brain areas associated with the execution of a mental task using Blood Oxygen Level Dependent (BOLD) functional magnetic resonance imaging (fMRI). 

The experimental protocol involves alternating 'active' phases, where subjects read a word and think about its synonyms and antonyms, and 'passive' phases, where subjects remain at rest. By analyzing the temporal evolution of oxyhemoglobin concentration, we aim to identify brain regions with significant changes in activity. 

The methodology includes data acquisition and preprocessing, modeling the hemodynamic response function (HRF), voxel-wise regression analysis, and visualization of activation maps. 

Results indicate significant activation in the left hemisphere, particularly in the prefrontal cortex, temporal lobe, and occipital lobe, highlighting their roles in language processing, decision-making, and visual processing. These findings contribute to our understanding of the neural mechanisms underlying cognitive tasks.

## Introduction

Blood Oxygen Level Dependent (BOLD) functional magnetic resonance imaging (fMRI) depicts changes in deoxyhemoglobin concentration consequent to task-induced or spontaneous modulation of neural metabolism [1]. Since its inception in 1990, this method has been widely employed in thousands of studies of cognition for clinical applications [1].

Neuroimaging researchers increasingly take advantage of the known functional properties of brain regions to localize activation regions in the brain and investigate changes in their activity under various conditions [2]. Using this noninvasive functional MRI (fMRI) method makes it possible to identify and localize brain activation [2].

In this experiment, a sequence of resonance image acquisitions of the temporal evolution of the volumetric distribution of oxyhemoglobin concentration, is taken during the execution of a mental task. 
The experimental protocol consists of 'active' phases in which the subject has to read a word and think about its synonyms and antonyms, and 'passive' phases in which the subject remains at rest. We want to identify the brain regions involved in this mental task   (those in which the concentration of oxyhemoglobin changes between the resting and active phases).

We solve this problem as a regression problem, considering the correlation between the hemodynamic response function (HRF) and the resonance image acquisitions.

## Methodology

The core steps of the analysis are described below.

### 1. Data Acquisition and Preprocessing

- **Data Loading:**  
  The fMRI dataset consists of 40 volumetric images (128×128×18 voxels each). Each volume is loaded using the `analyze75read` function.

- **Brain Mask Creation:**  
  To exclude voxels that do not belong to the brain, the mean intensity over time is computed for each voxel. A histogram of these averages reveals that voxels with intensities below a threshold (300) likely represent non-brain regions.

### 2. Hemodynamic Response Function (HRF) and Convolution

- **Defining the HRF:**  
  The expected BOLD response is modeled using a widely adopted difference-of-gamma functions approach. Standard parameters (a1 = 6, a2 = 12, b1 = b2 = 0.9, and c = 0.35) are used [3] [4]. This function models the dynamic change in blood oxygenation following neural activation.

- **Activation Profile and Convolution:**  
  The experimental protocol consists of alternating “active” phases (during which the subject reads a word and thinks of its synonyms and antonyms) and “passive” phases (rest). The activation profile is represented as a repeated pattern of active and rest periods.  
  By convolving the HRF with this activation profile, the expected blood oxygen level response is obtained.

### 3. Voxel-wise Regression Analysis

- **Regression Setup:**  
  For each voxel in the brain, a regression analysis is performed comparing its time series to the convolved (expected) BOLD response.

- **Computation:**  
  Given the large number of voxels (128×128×18), the regression is implemented within a parallel loop (`parfor`) to expedite processing. For each voxel with a non-zero signal, the regression returns several statistics:
  - **Correlation Coefficient** 
  - **F-Statistic** 
  - **P-Value** 

- **Noise Reduction:**  
  A 3D median filter is applied to both the correlation and p-value maps. This step reduces noise while preserving the edges of activation regions—critical for reliable fMRI analysis.

### 4. Visualization and Anatomical Overlay

- **Activation Maps:**  
  The voxel-wise correlation coefficients are visualized across the 18 slices of the brain. These spatial maps highlight regions where the BOLD signal significantly correlates with the task-related activation.

- **Significance Masking and Anatomical Context:**  
  Voxels with a p-value below 0.1 are considered statistically significant. These significant voxels are overlaid on an anatomical scan.  
  Given the anisotropic voxel sizes (0.9×0.95×5 mm), an affine transformation is applied to properly scale the images. Using a 3D viewer, the anatomical data (displayed in a neutral color scale) is combined with the activation map (using a hot colormap) to facilitate clear interpretation.

## Results

We can observe a significantly greater activation of the left hemisphere of the cortex, as it is primarily dominant for language in most people.

The results report a significant activation of prefrontal cortex whose subregions, such as the dorsolateral prefrontal (DLPFC) and orbitofrontal (OFC) cortices are known to have differentiable roles in cognition, including reasoning planning and decision-making [5]. In particular the DLPFC contribute more to the decision making phase, while the OFC is more involved in choice evaluation and uncertainty feedback [5]. 

We can observe a significant activation of the temporal lobe, particularly in Wernicke's area, related to language comprehension.

We see also a significant activation of the posterior cortex, specifically the occipital lobe which is the area primarily responsible for visual processing and which contains the primary and association visual [6].

## Authors

- **Simone Migliazza**
- **Giovanni Canini**

## References

1. Glover, G. H. (2011). Overview of functional magnetic resonance imaging. *Neurosurg Clin N Am, 22*(2), 133-139, vii. doi:10.1016/j.nec.2010.11.001. PMID: 21435566; PMCID: PMC3073717.

2. Madkhali, Y., Aldehmi, N., & Pollick, F. (2022). Functional Localizers for Motor Areas of the Brain Using fMRI. *Comput Intell Neurosci, 2022*, 7589493. doi:10.1155/2022/7589493. (Note: Retraction in: Comput Intell Neurosci, 2023, 9870415. doi:10.1155/2023/9870415. PMID: 35669664; PMCID: PMC9167083.)

3. Friston, K., Fletche, P., Josephs, O., Holmes, A., Rugg, M., & Turner, R. (1998). Event-related fMRI: Characterising differential responses. *Neuroimage, 7*, 30-40.

4. Frackowiak, R., Friston, K., Frith, C., Dolan, R., Price, C., Seki, S., Ashburner, J., & Penny, W. (2003). In *Human Brain Function* (2nd ed., Ch. 37). Elsevier Academic Press.

5. Demanuele, C., Kirsch, P., Esslinger, C., Zink, M., Meyer-Lindenberg, A., & Durstewitz, D. (2015). Area-specific information processing in prefrontal cortex during a probabilistic inference task: A multivariate fMRI BOLD time series analysis. *PLoS One, 10*(8), e0135424. doi:10.1371/journal.pone.0135424. PMID: 26258487; PMCID: PMC4530897.

6. Uysal, S. (2023). The Occipital Lobes and Visual Processing. In *Functional Neuroanatomy and Clinical Neuroscience: Foundations for Understanding Disorders of Cognition and Behavior* (Online ed., Oxford Academic, 20 Apr. 2023).



