thesis-bss
==========
List of matlab / octave script used on master thesis by bagustris.
The theme of thesis is binaural sound sources separation. Pdf file is available [here](https://www.dropbox.com/s/5wjsrrhxjw5oby3/bta_tesis_en_v16.pdf?dl=0).

In this thesis, I evaluated some common methods in binaural sound separation: ICA (with max likelihood estimation, ICA with Binary Mask (ICABM), binural model using phase difference channel weighting [4], and my-proposed-method FastICA with Binary Mask (FastICABM).

This is the source code for underdetermined separation of instaneous speech mixtures with FastICA and binary mask and the comparison for benchmark. 

The algorithm is described in

1. 	Michael Syskind Pedersen, DeLiang Wang, Jan Larsen and Ulrik Kjems: 
	Two-microphone Separation of Speech Mixtures, 2006, Submitted for publication.
2.	Michael Syskind Pedersen, DeLiang Wang, Jan Larsen and Ulrik Kjems, Overcomplete Blind Source Separation by 
	Combining ICA and Binary Time-Frequency Masking, IEEE International workshop on Machine 
	Learning for Signal Processing, pp. 15-20, 2005
3.	Hyvärinen, A., Erkki, H. 2000. Independent Component Analysis: 
	Algorithm and Applications. Neural Networks, 13(4-5):411-430, 2000
4. 	C. Kim, K. Kumar, B. Raj, , and R. M. Stern, “Signal separation for robust
	speech recognition based on phase difference information obtained in the fre-
	quency domain,” INTERSPEECH, pp. 2495–2498, 2009.


All files should be in the same directory. 
The algorithm is run by calling each icabm.m and fasticabm.m. 
For ICA algorithm, it can be run directy from worskpace and for PDCW it can be obtained from the [source](http://www.cs.cmu.edu/~chanwook/MyAlgorithms/PDCW_IS2009/INTERSPEECH2009Package.zip).

A number of parameters can be specified in those files.

- N 			: Number of sources in mixture
- NFFT 			: DFT length
- winnumber		: Selects window function
- k			: Window length is NFFT/k
- noverlapfactor	: Overlap between consecutive windows
- th 			: Mask threshold?
- TC1			: Merge finalstereo signals if correlation is above TC1
- TC2	 		: Merge finalstereo and enerstereo if correlation is above TC2
- stopthresholdini	: One source if condition number is above this value
- thepow		: tau_E (see [1])

All codes is copyrighted by its own author. The codes from me are licensed GNU/LGPL v2.
Run `main.m` to get the demo. You can change the input file by your own data. 
