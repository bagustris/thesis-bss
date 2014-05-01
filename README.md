thesis-bss
==========
list of matlab / octave script used on master thesis by bagustris.
The theme of thesis is binaural sound sources separation. Pdf file is available [here]( http://www.mendeley.com/download/public/6887973/5393254001/c61cc0b8ee45c17e75481e01ee01a6a3b2ca0ac2/dl.pdf)

This is the source code for underdetermined separation of instaneous speech mixtures with FastICA and binaural mask and the comparison for benchmark. 

The algorithm is described in

[1]	Michael Syskind Pedersen, DeLiang Wang, Jan Larsen and Ulrik Kjems: 
	Two-microphone Separation of Speech Mixtures, 2006, Submitted for publication.

[2]	Michael Syskind Pedersen, DeLiang Wang, Jan Larsen and Ulrik Kjems, Overcomplete Blind Source Separation by 
	Combining ICA and Binary Time-Frequency Masking, IEEE International workshop on Machine 
	Learning for Signal Processing, pp. 15-20, 2005

[3] Hyvärinen, A., Erkki, H. 2000. Independent Component
Analysis: Algorithm and Applications. Neural Networks, 13(4-5):411-430, 2000


All files should be in the same directory. 
The algorithm is run by calling main.m. 
A number of parameters can be specified in main.m:

N 			Number of sources in mixture
NFFT			DFT length
winnumber		Selects window function
k			Window length is NFFT/k
noverlapfactor		Overlap between consecutive windows
th 			Mask threshold?
TC1			Merge finalstereo signals if correlation is above TC1
TC2	 		Merge finalstereo and enerstereo if correlation is above TC2
stopthresholdini	One source if condition number is above this value
thepow			tau_E (see [1])
