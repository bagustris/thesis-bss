This note is based on timeline (first to last; first appears first).

---  
Dear Sensei,

I Uploaded my new sound files including surrounding noise here ( I think I made some mistakes on previuosly uploade file)

https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111029154555/new_result_bta.tar.gz

I add surrounding noise to two channels. The target vs surrounding noise is 30 dB.

I found in my result that delay occurs between estimated signal and original signal I posted in azukaruze link below,

https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111029151109/ori-est-pdcw.eps

So, I can not used SDR and friends for objective evaluation because they required the same length between original and estimated signal. I have tried to use segmental SNR which the code available in our library (Calc_SegSNR.m) by comparing estimated signal and original true signal. But it also require the same length. I can make it same but cut the length of signal, but is it objective? Only the output of FastICA has the same length with the original source

Regarding to those issue I postponed to send you my revision. But, I will keep working tonight to finish my paper. All is almost done except the objective evaluation.

Looking forward for your advice and suggestion.  

---

Mr. Bagus,
please access the following file and please
make a proof read after revision.

Other comments;
1) Figures, Tables and references should be in order.
2) Figures and Tables should be on the page or the next
    of the referred sentence.
3) Simulation condition is un-realistic. You need to understand
   it more clearly.
4) Evaluation indexes are not proper to provide information on
   performance. You need to think about the proper why to evaluate.
5) Please upload the audible WAV files for
     the original target, the observed signal, and the enhanced target.
    
---  
Dear Mr. Bagus,

I had listened the sound files in
  new_result_bta.tar.gz

Observed signal, especially for hrtf based simulation and
observed signal by dummy head, should be save as WAV file of
stereophonic so that human being to identify the target, interference
as well as surrounding noise in binaural hearing condition.

About enhanced signal:

output_fastica_exp as well as fastica_sim:
  there are points to exceed the maximum and those produce the
  many noise.  You need to make clear the maximum of enhanced
  signal in floating point is within the range of 16bit PCM.
  If the enhanced signal is within the 16bit PCM, the algorithm
  should be checked.

output_icabm_exp:
    there are two channels but only one channel has signal with very
   small level.  And the sound quality is very bad and long low frequency
   component is remained.

output_pdcw_exp:
    noise in mid frequency range is reduced and quality is best for all
    three output_*_exp.wav.

When you make signals, please listen by yourself first.
And please compare the listening impression with various indexes which
you calculate.

Yours,  
tuie

---  
> Dear Sensei,
>
> Thank you.
> The interfering noise which I used also is white noise.
> If you suggest me to add two white noises more, it means I mix four sound
> sources received by two-input, right? If yes, I will add white noise with
> different dB SNR (20 dB and 40 dB) to two-inp
---   
Dear Mr. Bagus,

there is "one" interference noise sound which is observed
at two microphone with different amplitude for your case.
I suggest to add independent noise for each channel in order
to take into account noise due to equipments and quantization
noise.
So,  s(t) = target, i(t) = interference, n_r(t) = independent noise for r channel,
n_l(t) = idependent noise for l channel.

Observer signals at two microphones are  
 y_r(t) = h_t_r(t) * s(t)  + h_i_r(t) * i(n) + n_r(t)  
 y_l(t) = h_t_l(t) * s(t)  + h_i_l(t) * i(n) + n_l(t)  
where  
  h_t_r(t) and h_t_l(t) stand for impulse responses from
target source to left and right channel. (Please consider the delay as well.)  
 and  
h_i_r(t) and h_i_l(t) stand for ones from interfere to left and right channel.

 and
 asterisk is the convolution in time domain.

Yours,  
tuie

---  
Dear Sensei,

Thank you very much for your reply.

I add two noises to two channel after convolved the sources signal with hrtf (hrtf_mic_r_withsurnoise.wav  in the files I sent).
It looks similar with your explanation.

How about the objective evaluation? Because the output files are different
length, I found difficulty to compare two signal except perceptually by
listening the sound and see the plot in details. 

---  
Dear Mr. Bagus,

about the way of writing, please refer the previous PDF which I have
commented on.
Note that the word "we" in the document mean readers (as well as authors);
not authors.

Other comments are ;
0) About the authors' names, please write full-spell instead of initials.

1) Title of chapter 2 "Theory" is not proper because those methods are
   proposed a priori  and  your paper's position is "to compare those."

2) Current pragraph between "2. Theory" and "2.1 Binaural Model"
  should be written in Introduction because you need to mention why
  you need to compare those conventional methods.

3) Order of figures and position of figures are out of order and not
   proper.
   If you are using Latex, not write figure number directly and use
   the reference to get figure number.
  (Figure 3 appeared in left column in p.2, but there are not Figure 1 nor
   2 before that. Figure 1 & 2 are referred in p.3. And Figure 3 is in p.4.)

4) Many terms in equations are not clearly defined.
    Eq.(1)  x_L[n], x_R[n], \delta[n]  are not the mentioned.

5) The parameter d(k, m) in p.2 is not the used so any other place.
    Necessity of expression is not clear nor k and m are not mentioned
   at all.

6) Expression in Equations are not inconsistent.
    In 2.1, sampled signals are used such that x[n].
    In 2.2, continuous signals are used such that x(t).
    S(f) is defined as frequency domain expression of s(t),
    but you omit f in Eq.(5) and surrounding sentences.
  Rewrite whole algorithm in sampled signal expression.

7) Definition of norm used in Eq.(7) is not given.

8) Eq.(8) need =.

9) Put the signal labelling such as s[n], i[n], and x_L[n] in Figure 3
   as well as for the distance assumed or used.
   If 45 degree means the azimuth, you can not write at the source
   position, but write as the angular expression

  ```
      \    |
       \ 45|
        \  |
         \ |
          \|
  ```

  Define the coordinate.

10) About the color,  there are not special reason to use the color
   in Fig.1, Fig.2 and Fig.3. Remove the color attribute if it is
   not really necessary.

11) In results,
   You need to put the subsection as 4.1 Simulation  and 4.2 Experiment.
   And it is not clear whether it shows the results for simulation or
   experiment. You need to mentioned in sentence as well as capture.

   Necessary figures are such that
    Figure 5   Results of Simulation;  Target signal, Observed signal at
         left, Observed signal at right, Enhanced signal by PDCW,
         Enhanced signal by <all other methods>

   Figure 6   Results of Experiment:  <Same as above.>
   Figure caption /labels should be BELOW the figure.
    (Don't write "Observed signal" above the waveform plot.)
    Labels in the each of plot are too small. Please the
    font size no smaller than 80% of font size of sentence.

12) In Table 1. results of simulation should be remove.
    For the simulation, additive noise is very principle condition.
   About the values,  please let me know how you measure the
        SNR
   for enhanced signal?  (Please define as Equation.)

13) Again, there are several syntax errors, so please check when you
   draft;   correspondence between subject and verb,

14) Paper titles in the references should be written within double
  quote and remove the double attribute.

**I am sorry, but it is not yet finishing stage yet.**

---  
Dear Sensei,

Thanks a lot for your review, I will revise it again.
Here my code for calculating SNR, I use variance to measure power.

```
Signal=enhanced_signal;
noise=original_noise_16k;

%Calculating Signal and noise power from their variance
signalPower = var(Signal);
noisePower = var(noise);

%Calculate Signal to noise ratio for the Signal and Noise
SNRratio = signalPower/noisePower;
measuredSNR=10*log10(SNRratio)
```
---  
Dear Mr. Bagus,

var(x) is defined  
>   var (x) = sum(power(x-mean(x), 2))/(length(x)-1)

this is what you means for
> SNRratio = signalPower/noisePower;

Definition of SNRratio should be  
>   SNRratio = sumsq(signal) / sumsq(noise)

2. before that. Figure 1&  2 are referred in p.3. And Figure 3 is in p.4.)

Please check it.

Yours,  
tuie

---   
Dear Mr. Bagus,

thank you for your revision. I have confirm your revision
and it is much clear to discuss.

> 3) I tried to order the figure, I use \ref{labelname} from the beginning, but I don't know why it
got error, I fix it manually.
Would you let me know the eror that you get, or
make a test source file with same style file in order to check the referencing.

About the results,
1) noise level is very different between observed signals in
  Fig.5 and Fig.6.

2) there are time shift, especially one violate the causality, between the
  observed and enhanced signals of PDCW both for Fig.5 and Fig.6.

About documents, I will try to reply until tomorrow noon, but I may
reply tomorrow night.

---  
> Dear Sensei,   
> 	
> I uploaded my revision in link below,
> https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111031144457/bta_asj_kyushu_meeting_template_v3.pdf
>
> I use SNR as you explained.
>
> 0) I have changed the the authors' name with full-spell instead of initials
> 1) I change the section 2 from "Theory" to "Methods"
> 2) I cut the paragraph between 2 and 2.1 and put it ins section 1.
> 3) I tried to order the figure, I use \ref{labelname} from the beginning, but I don't know why it got error, I fix it manually.
> 4) I tried to make equation clear and simple, such as FastICA, otherwise, I suggest to refer correspondent paper for more details.
> 5) I add some remarks regarding those expression
> 6) I change all equation to sampled time
> 7) I add definition for norm and why it is used
> 8) I add "=" to Eq (8)
> 9) I add signal labels in figure and the coordinate
> 10) I remoce unnecessary  color
> 11) I add result of simulation and experiment in waveform figure
> 12) I remove simulation and table, only simulation with additive noise
> 13) I tried to make the sentences agree between subject-verb
> 14) I add double quote to paper title, and remove bold font

---  
Dear Mr. Bagus,

First of all, keep the CC hicc-all to share the situation across the
lab.


About the figure, just send the source around figure.
(It seems that you reference is looking for section not figure.)

for example, you can refer as the figure
```
\begin{figure}[b]
 \begin{center}
  \includegraphics[width=0.5\columnwidth]{./figs/mic_head_set2.eps}
  \caption{Canal ...}
  \label{fig:HAprot}   %<<<=== this is the label
 \end{center}
\end{figure}
```
by
> microphone and earphone shown in Fig.\ref{fig:HAprot}.

1) If you set fix the amplitude of the source position and the
  set the signal level at the source position, it should be the
  same both for simulation and experiment.

  How did you set the signal level at source position for
  target and noise?


2) If the original code has an time lag, you need to compensate to it
  otherwise you are not able to compare with other algorithims.
  The time lag should be estimated by reading source or by simulation for various
  source such that impulse.

tuie

---  
Dear Sensei,
>
> Thank you for your reply.
> The error just for figure 5 and 6, I use \ref{labelnamefig5} and \ref{labelnamefig6}
> But it appears like this,
> Fig. 4.1 and Fig. 4.2
>
> About the result,
> 1.) Yes, the observed signal from experiment has low amplitude, I think it is caused by attenuation of sound wave from source to microphones in dummy head. I try not to amplify it.
> 2). Yes, I checked the original code and demo, it also has time shift. I
> think this is caused by algorithm.
	
---  
Mr. Bagus,

beside the comments which I have sent last night,
I would like to ask you one more thing.

3) The vertical axis of Fig.6 (b)(c) are 1.05 not 1.0, thus
the scale is not the same to others. Please check the scale
of the signal because Fig.6(b)(c) should be the recorded signals
thus they can not be more than 1.0.
(Also the scale should be the same for comparison.)

Yours,  
tuie

---  
Dear Sensei,

1). So I understand why the observed signal between simulation and experiment are very different. I didn't set up the level signal yet.
How to set up the source level signal? Can I set up manually? for example, like my previous methodt: x_l(t)=0.6*s(t) and so on.

2). I checked the time lag for pdcw, and it has the constant time lag for the the same signal length
So, I can cut all signal and make the length same to the output of pdcw algorithm and compare it

Thank you for your help about latex and looking forward for your advice.

---  
Dear Sensei,

In Fig 6(b)(c) actually the level is not 1.05, but 0.05. (I don't know
why the figure is cut by latex, I also include ylabel('amplitude'), but
it also not shown).

I have set the maximum level (both itunes and audio pc) when record but the recorded signal has
small intensity level. I also got this result when I do my experiment in
Indonesia, the max amplitude only 0.002 using condenser mic with TRS
connection. It depends on distance and mic characteristics. The better
result was achieved using XLR connection microphone.

About the output of pdcw, I have tested with some inputs and the time lag is constant.
So, I can cut other outputs length to be the same with output of pdcw and
compared to others

And how to set source signal levels when convolving with hrtf?

---  
Dear　Mr. Bagus,


 > I have set the maximum level (both itunes and audio pc) when record but the recorded signal has
 > small intensity level. I also got this result when I do my experiment in

please specify the block diagram for experiments
with equipments specification.

The volume control of PC is not sufficient if your selection of
microphone is not proper.

For example, your microphone's maker and product
code with produce specification.

---  
Dear Mr. Vecky and Mr. Bagus,
in order to finish the ASJ-kyushu documnets, please stand
by at 12F on 16:30 tomorrow afternoon.
(This is the last chance to talk directly to you before the deadline,
 because I will be Tokyo on Nov. 4th.)

Yours,  
tuie @ Sendai, Japan

---  
Dear Sensei,

I did what you sugested last night to compute residual signal as noise with the following formula,

> residu=s_hat-s			where s_hat and s are in the best fit

But, from the waveform we can get the information that the power of true target signal is bigger than enhanced signal or s_har has the smaller power than s.
In the case of the formula above, residu can be said as error.

> residu=s_hat-s	residu=error (of measurement)

So, as alternative, I use MSE (mean square error) to compute error between true signal and enhanced signal.
> mse=1/n*(sum(error.^2)) 		n=length of signal

I make two version of my paper, one used SNR and another used MSE. 
For MSE-based evaluation is here,

https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111104102226/asj_kyushu_meeting_template_mse.pdf


And for SNR-based evaluation is here,
https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111104103721/asj_kyushu_meeting_template.pdf


Thank you very much for your advices, and please let me know if I can send one of those paper.

---  
Dear Mr. Bagus,

did you compensate the gain and latency?
If you did not,
> residu=s_hat-s                        where s_hat and s are in the best fit
never works.

The given score given in
> https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111104102226/asj_kyushu_meeting_template_mse.pdf
are very strange.

Please make
  s(n)
and
  s_enhanced(n)
has the same peak level and the delay between s(n) and s_enhanced(n) can
be obtained by cross-correlation.

MSE is also the same issue if you use
  untreated  ERROR = s(n) - s_enhance(n)

Please be hurry to revise it.

Yours,
tuie 

---  
Dear Mr. Bagus,  
CC: Mr. Saho,


both mse and snr you have send are not able to use.
I will start to move to Waseda Univ. thus I would be out of
network until 12:30.
Looking foward to having your revised information.

Yours,  
tuie  

=> Mr. Saho, please mail the draft of Mr. Vecky first.
      I am very afraid that Mr. Bagus's draft can not send today. 

---  
> Dear Sensei,
>
> If what you mean is normalization to make the range of output signal same with the input signal, yes I have done it o that paper.
> About cross correlation, how to use it.
> I do this
>
> [R, lag]=xcorr(signal, enhanced_signal);
>
> and I got error syntax error: number of rows must match
>
> Whereas the length of signal and enhanced signal is same.

---  

Dear Mr. Bagus,

> and I got error syntax error: number of rows must match

take length(signal)
and  length(enhanced_signal)

and the make them the same.

This kind of thing can be solve by labo members, so do not waste
the time.
I am sorry that I can to keep in touch the network because of limit
power of PC.
I will contact to once every hour around X:00-X:10.

If you hear the ERROR (s(n)-s_enhanced(n), you will get
  echo if the lag is not properly calibrated,
  strong signal if the level is not compensated well.
Please check it first.

Yours,  
tuie

PS Don't remove cc to hicc-all to share the information, especially such
  a kind of situation;  need to make a very soon, and some thing like
  "error message" of programing language. 

---  
Dear Sensei,

Yes, the length of signal is same.
Mr Saho and me computed the time lag between signal from various its peak, the snr still strange;
for fastica, snr(dB)=   -0.871;       enhanced vs residu
We also adjusted the level to have the same peak.

Looking forward for your advice.

---  
Dear Mr. Bagus,

the information you have provided is not enough.

Did you hear the residual?
Please send the information about
 the length of data for target, observed, three enhanced.
also
 the mag. of normalized signals (T, O, 3 E)
and
 the time lag to compensate latency for O and 3E.

Yours,
tuie  

---  

Dear Sensei,

Thank you for your reply,

Yes, I hear the residual, it similar to the target signal
Firstly the length of target, observed left right, result_fastica and resullt_icabm are 80000 samples
for result_pdcw is 77599, then I make all have the same length i.e 75198 (for simulation)


			T			Obs_left 	Obs_right	result_pdcw		result_fastica		result_icabm 	
mag max			0.99518			1		0.9999		0.90897			0.9998			0.9998
	 min		-1			-8.217		-0.8263		-0.78693		-0.5526			-0.9291


Time lag to compensate:  
result_fastica = 257 samples  
result_pdcw=1179 samples  
result_icabm= 16 samples  

I uploaded my newest data here,
https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111104162344/bagusdata.zip
 
---  
Bagus,

please insert CR within 80 char or less otherwise
I can not make a correspondence.

For result_pdcw is 77599, then I make all have the same length i.e 75198 (for simulation)

```
        T  Obs_left  Obs_right  result_pdcw result_fastica result_icabm   
mag max 0.99518 1 0.9999  0.90897 0.9998  0.9998  
min   -1  -8.217 -0.8263 -0.78693 -0.5526 -0.9291
```

Please explain how you can normalize and compensate the delay.

And be at 12th floor tomorrow 15:00.

Yours,  
tuie

---  
Dear Bagus,

I got your sound files.
There is no explanation about the files.
There is a file named "datacutexp" and "dataexp" but there is no extension.

Please inform send the file information in PLAIN TEXT or
PDF.

I need to board now and I will go back to my home tonight.
I will come to 12th floor on 15:00 tomorrow thus please be stand by. 

---  

Dear Bagus,

I could not find out the sound files after normalization.
Please send the sound files after normalization and time lag compensation;
in other word, sound files used for subtraction to obtain error signal.

Yours,  
tuie

---  
Dear Mr. Bagus,

I found out the data in *.mat for octave.
And I have tried to compensate the linear filter, but
the phase information are completely destroyed for the
enhanced signals and the temporal characteristics of phase
are not the stable.

Tomorrow, not tonight, please install PRAAT to get the spectrogram.
One of the solution to express the performance of processing
would be an spectrogram.

Also I will check the change of coherences between target and
observed, as well as target and enhanced.

Yours,
tuie 

---  
Dear Mr. Bagus,

I calculate the coherence:

1)
```
coh_ob   = coherence(signal, obs_mic_l_16k, 512);
coh_fica = coherence(signal, result_fastica, 512);
coh_icabm= coherence(signal, result_icabm, 512);
coh_pdcw = coherence(signal, result_pdcw,  512);
```

please plot them such that
> plot(coh_fica(1:256), "", coh_ob(1:256));

As far as I see, the performance of all of three methods
are not so high for the condition you have check.

2) The averaged coherence over frequency can be an index;
```
coh_ob:
sqrt( (coh_ob'*coh_ob)/length(coh_ob)
0.22893

coh_fica
0.35149

coh_icabm
0.27710

coh_pdcw
0.28305
```
Those indexes provide the order as
 coh_ob<    och_icbm<    coh_pdcw<    coh_fica

Yours,
tuie

--- 

Dear Sensei,

I have tried to calculate the coherence and got the following error,
```
octave:10>    coh_ob=coherence(signal, obs_mic_l_16k,512);
Warning: Octave:deprecated-function
Warning: Octave:deprecated-function
parse error near line 13 of file /Users/admin/Desktop/lib/is_cvector.m

  syntax error

     if ( columns(x)<>    1)
                                          ^
```
I try to by pass the function by using powerSpectrum but i got the same error.

---  
Bagus,  
have a lunch and take a rest for a while until 15:00.

Yours,
tuie

---  
Dear Sensei,

Thank you very much for your short-course this afternoon.
I will send my draft tomorrow morning because I don' t have internet access in my IH room.
Maybe I will send about 6-7 am.

bta

---  
Dear Mr. Bagus,

looking forward to having your draft tomorrow morning.
My rough schedule would be

9:00-9:40  move to Kumamoto AP
        <after checkin,  I will connect to the net.>
10:30-12:30  flight
13:00-14:20 Move from Haneda to Narita by express bus
15:00-17:00  at Narita
        <after checkin,  I will contact to the net.>

Please take care of health condition as well.

After finalizing the draft, I will ask you to submit
via email first, then try to post the draft.
Before going to the Main post office, please check
the correcting timing of the post in front of University
or closing post. The collection will be on Sunday I think.

Yours,  
tuie

---  
Dear Sensei,

I uploaded my draft below,
https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111106075209/bagus_asj_kyushu_meeting_template_v4.pdf

---  
Dear Mr. Bagus,

this is the first part of comments.
Please reply one by one how you have tried when you
reply to this email.

1) p.1, bottom,
  please put those in stead of current line "* Corresponding ..."

   2-39-1 Kurokami, Kumamoto 860-8555
   {bagus@hicc, cxx@cs, txxx@cs}.hicc.cs.kumamoto-u.ac.jp,
   <<Dxxx's e-mail>>

2) p.1, left column, last two sentences of "Abstract"
OLD:
"target speaker from interfering noise.
Finally, coherence criterion is used to measure
the performance of those methods."
=>
NEW:
Performances were compared by means of spectrograms as well
as coherence."

3) p.1, left column in middle
OLD:
"processing
solved this problem is exactly unanswered
until this time. However, many scientist
and engineer proposed some methods."
=>
NEW:
"processing
solved this problem is not yet cleared until new.
However, many researchers have proposed various methods."

4) p.1, left column, bottom until right column
OLD:
"This paper compared
three different algorithm in sound separation.
  The rest of this paper will review three
algorithms in Sec. 2 while Sec. 3 shows the
experiment design and set-up. Result and
conclusion are described in Sec. 3 and 4."
=>
"This paper compares
three methods in sound separation task."

<<Please stand the reader's point of view.
  Reader has not yet looked the results so
  present tense is proper.
  And there is only four pages, so the structure
  of the paper is not necessary. It is redundant.>>

5) p.1, right column first paragram
OLD:
"The model of human binaural hearing
commonly was derived from binaural cues
i.e. ITD (interaural time difference) and
ILD (interaural level difference). The binaural
model used in this paper is derived from
phase difference in frequency domain to estimate
the ITD as described in [1]. The binaural
model refers to phase difference channel
wighting (PDCW) and it can be shortly
explained as follows. The two microphones
recorded sound from the target speaker and
interfering white noise. The first process
is STFT which decomposes two sound signals
in frequency and time, then ITD is estimated
through comparison of two signals
at each frequency. The time-frequency (t-f)
mask identifying the ITDs which was close
to the target speaker’s ITD is identified. The
gammatone channel weighting works on that
subset and the resynthesizes process was obtained
using inverse STFT and overlap-add
method."
=>
NEW:
"  Most models of human binaural hearing
are derived from binaural cues
i.e. ITD (interaural time difference) and
ILD (interaural level difference). The binaural
model examined here is derived from
phase difference in frequency domain to estimate
the ITD as described in [1]. The binaural
model is refered to Phase Difference Channel
Weighting (PDCW) and it is described as follows.
At first, binaural signals are observed by two
microphones are transformed into time-frequency
domain by means of STFT. Then ITD is estimated
through comparison of binaural signals
at each frequency. The time-frequency mask is
identified in time-frequency domain at which
ITDs are closed to the ones corresponding to the
target source. After the gammatone channel weighting
is applied, the resynthesis process is performed by
means of inverse STFT and overlap-add method."


<<Note that "past tense" is used
   it was true, but it is not true NOW
 when you write the theory.>>


I will send the second part soon.

tuie

---  
Mr. Bagus,

this the second part.

6) p.1, right column bottom to p.2 left column top.
OLD:
"Mathematically, the two sound signals
reaching microphones can be formulated below,
  (1)
with xl and xr represent signal from left and
right microphone from dummy head and !(l)
is ITD from sources. Using STFT can be
obtained the Fourier of those signals. Correspondingly,
the parameter ! in the Eq.(1)
can be replaced with the frequency dependent
ITD parameter d(k,m), where k is frequency
index and m is the frame index. Furthermore,
details explanation of PDCW algorithm
can be found in [1]. By assuming a
specific time-frequency bin is dominated by
single source, it can be decided using binary
decision whether the time-frequency bin belongs
to target speaker or not."
=>
NEW:
"Although the details explanation of PDCW algorithm
can be found in [1], key of this method is
how to identify the specific time-frequency bin
which is dominated by single source.
PDCW makes the binary decision whether the time-frequency
bin belongs to target source or not based on the
ITD for each time-frequency bins.

<< Eq.(1) is not proper because there is no HRTF (or HRIR)
  thus the discussion after Eq.(1) is not completed.
  Just remove those as suggested above.>>

I will write later.

yours,  
tuie

---  
Dear Mr. Bagus,

please keep cc otherwise you need to contact Prof. YC
separately by yourself.

rev-1) p.1, left column, l. 5 of Abstract
OLD:
"methods. In this paper, some existing meth-"   
=>  
NEW:  
"methods. In this paper, three conventional meth-"

rev-2) p.1, left column, l.3 of "1 Introduciton"
OLD:  
"sound than others. The binaural ears work"  
=>  
NEW:  
"sound than others. The left and right ears work"
 <<Note "binaural" means "perceptional process by means of
   left and right ears," and it is not an  "adjective"
   for ear.
  Check google or so "binaural ear." Rare in academic documents.>>  

rev-3)  p.1, left column, l.6 of "1 Introduction"
OLD:  
"mechanism. How the human auditory pro-   
cessing processing solved this problem is"  
=>  
NEW:  
"mechanism. How the human auditory pro-
cessing solved this problem is"
 << Double "processing" thus remove the second.>>

rev-4) p.1, right column, l.8 from bottom
OLD:  
"and overlap-add method Although the de-"  
=>  
NEW:  
"and overlap-add method. Although the de-"
                      ** DON'T forget "." in the end of
sentence.

rev-5) p.1, right column, l.4 from bottom  
OLD:  
"which is dominated by single source. PDCW"  
=>  
NEW:  
"which is dominated by target source. PDCW"
                       ******

rev-6) p.2, left column, in "2.2 ICA"  
OLD:  
"Let s(n) be sampled signal of sound signal,"  
=>  
NEW:  
"Let $\bf{s}(n)$ be sources' signals,"
<<Put "bold" attribute to s(n) because "s(n)" should be a matrix.>>

rev-7) p.2, left column, l. 4 in "2.2 ICA."
OLD:  
"cally mutually independent sources s(n) ="
=>  
NEW:  
"cally mutually independent sources $s$(n) ="
<< s(n) seems not italic (or not in math.)>>

rev-8) p.2, left column, Eq.(2)
<< right hand side of Eq.(2) should be
   \sigma_{l=0}^{L} \bf{W}(l) \bf{x}(n-l),
  Please check whether s(n-1) is correct or not.>>

rev-9) p.2, right column, l.2 in "2.3 ICA ..."  
OLD:  
"tion 2.2, the ICA with time-frequency mask-"  
=>  
NEW:  
"tion 2.1, the ICA with time-frequency mask-"
       *** it refers to section of binaural model.

rev-10) p.2. right column, l. 5 in "2.3"
OLD:    
"within critical band [3]. The mask M(n; k)"  
=>  
NEW:  
"within critical band[3]. The mask M(n; k)"
                   **** remove space between "band" and "[3]."

rev-11) p.2, Eq.(5)
<<
"m(t,f)" should be "M(n, k)" as mentioned in l.6 of
"2.3 ICA .."
and
 "s(t,f)" should be "S_1(n,k)" and
 "n(t,f)" shoud be "S_2(n,k)"
because in Eq.(2) you expressed multiple sound sources
as  s_1(n), s_2(n), ... and there no interference in
this expression.>>

rev-12) p.3,  
OLD:   
"4 Result of Experiment"  
=>  
NEW:  
"4 Results of Experiment"
<      *** make "result" in plural form because
 there are several results.>>


rev-13) p.3, left column, l.3 in "4 Results of Experiment"  
OLD:   
"signals. The order of plots in those figures
are,"
=>  
NEW:  
"signals. The order of plots in this  figure
is,"
<<because there is only one figure, Fig.3.>>

rev-14) p.3, left column, in the middle.  
OLD:  
"nals. In this Table, results of simulation are"  
=>  
NEW:  
"nals. In this table, results of simulation are"
              **** make lower case.

 
rev-15) p.3, left column, in the middle.  
OLD:  
"also provided for the comparison According"  
=>  
"also provided for the comparison. According"  
                            ****
<<  sentence must terminated by the period (".").>>



rev-16) P.3, right column, in "5 Conclusion"  
OLD:  
"The re-
sult of performance is shown by coherence
function for simulation and experiment data.
Based on coherence measurement, the Fas-
tICA algorithm work better than PDCW
and ICABM."  
=>  
NEW:  
"The re-
sults of performance are shown as averaged
coherence for simulation results as well as
experimental results.
Based on the averaged coherence, the
Fast-ICA algorithm work better than PDCW
and ICABM."
<<Don't put "-" unproper postion. You may insert
  "-" within a word at the position mentioned in the
  English dictionary. >>


rev-17) p.3, right column, in "5. Conclusion"  
OLD:  
"this paer, it is necessary to compare other"  
=>  
NEW:  
"this paper, it is necessary to compare other"
        *** use SPELL-checker.

rev-18) p.3, right column, in "5 Conclusion"  
OLD:  
"methods such as [6] which is ready to imple-
mented as [7]."  
=>  
NEW:  
"methods such as [6] which is ready to be imple-
mented as [7]."                       **** syntax.


After you have revised the above mentioned points rev-1 to rev-18,

please submit the draft to the committee to CC to me.
Once you get the any reply from the committee, please forward
to hicc-all to let all of us know.

Beside that, please submit the printed draft at closing postoffice.
(I think it is already too late to go to main postoffice, thus,
 post the envelope at the local postoffice beside the University or
 in between IH and the compus.)

Anyway, I am appreciate your efforts.

Yours,  
tuie @ Narita AP.  About half hour before boarding.

---  
Bagus,

part 3:

7) p.2, left and right column
OLD:
"variable. In this paper, FastICA algorithm
was used as introduced by Aapo Hyarinen
[2]. FastICA algorithm used non-gaussianity
measure based on negentropy. This algorithm
was formulated by fixed-point"

=>

NEW:
"variable. In this paper, FastICA algorithm
introduced by Aapo Hyarinen[2] is used.  FastICA
algorithm uses non-gaussianity measure based on
negentropy. This algorithm
is formulated by fixed-point"

<<You need to write as the present tense because
  FastICA is used in this paper and this evidence
  is not changed (can not be changed).>>

8) p.2, right column, top
OLD:
"from Newton’s methods."
=>
NEW:
"from Newton's methods."
 <<Don't use ZENKAKU(JAPANESE) "'" in English text.
  You need to keep the constant expression of signals:
     s1(n)  :  target signal
     s2(n)  :  interference
     x1(n) and x2(n) : two observed sigals
     y1(n) and y2(n) : estimated (enhanced) s1 and s2
  here after.>>

9) p.2, title of 2.3
OLD:
"2.3 Time-Frequency Masking"
=>
NEW:
"2.3 ICA with Time-Frequency Masking"

<<You need to pay much attention about the consistency
 of expression within a draft.>>

I will send the part 4 from Tokyo about 2 hours later.

Yours,  
tuie

--- 
Dear tuie,
> I have revised three parts as you suggested.
> Looking forward for the fourth part.

---
Confirmed.

Please remember that
>>   You need to keep the constant expression of signals:
>>      s1(n)  :  target signal
>>      s2(n)  :  interference
>>      x1(n) and x2(n) : two observed sigals
>>      y1(n) and y2(n) : estimated (enhanced) s1 and s2
>>   here after.>>
>>

tuie
	
---  
Bagus

I am in Haneda and I will start to move to Narita.
It will take a hour by express bus.

About the simulation, I skipped because the SNR condition
is not clear and it is not corresponding to the
experiments.
(This should be made clear before you make a presentation.)

Looking forward to having your revised draft.

Yours,  
tuie

---  
Dear Mr. Bagus,

I got your draft.
Please inform me the following;
> Dear Mr. Bagus,
>
> this is the first part of comments.
> Please reply one by one how you have tried when you
> reply to this email.
>
> 1) p.1, bottom,
>   please put those in stead of current line "* Corresponding ..."

(you may reply one by one for each of part.)

yours,   
tuie

---  
Dear Sensei,

1) I replace "coresponding author:..." become
new:

2-39-1 Kurokami, Kumamoto 860-8555 
(bagus@hicc, xxx@cs, xxx@cs).hicc.cs.kumamoto-u.ac.jp, xxx@ep.its.ac.id

---  
Dear Sensei,

I reply one by one.
2). 
I change the last two sentences in abstract to:
 Performances were compared by means of spectrograms as well as coherence.

3). I change to..
..processing solved this problem is not yet cleared until new. However, many researchers have proposed various methods to approach the cocktail party phenomena
4). I change those sentence in last introduction to:
Most models of human binaural hearing are derived from binaural cues i.e. ITD
(in- teraural time difference) and ILD (interau- ral level difference). The
binaural model ex- amined here is derived from phase difference in frequency
domain to estimate the ITD as described in [1]. The binaural model is ref- ered
to Phase Difference Channel Weight- ing (PDCW) and it is described as fol-
lows. At first, binaural signals are observed by two microphones are
transformed into time-frequency domain by means of STFT. Then ITD is estimated
through compari- son of binaural signals at each frequency. The time-frequency
mask is identified in time-frequency domain at which ITDs are closed to the
ones corresponding to the tar- get source. After the gammatone channel
weighting is applied, the resynthesis pro- cess is performed by means of
inverse STFT and overlap-add method.

---  
Bagus,

can you reply to make clear which part you have changed
from my comments?

If you changed accordingly, you may reply as
 "changed as above."

Anyway, please reply my "rev-XX" comments first.

I will have about 15 min.

Yours,  
tuie

---  
Dear Mr. Bagus,

*This is part 4*
> flight was slightly delayed due to delayed departure.

10) p.2, right column, middle
OLD:
"Actually, both binaural model and ICA
in third method use time-frequency mask.
The masks applies a weight to each T-F
unit so that spatial-temporal that are dominated
by target speaker are enhanced and
others are suppressed. Perceptually, this
idea is motivated by human auditory phenomenon
in which a sound is rendered by
louder sound within critical band [3]. One
of time-frequency masks is the ideal binary
mask proposed byWang et.al. They denoted
the target signal as s(t, f) and the interference
noise is n(t, f). Then the ideal binary
masks is defined as
 m(t, f) =  Eq.(6)
where t and f are index of time and frequency.
Parameter " is choosen to be 0 corresponding
to 0 dB criterion [3].
The three methods used in this paper
are PDCW, FastICA and combination of
ICA with binary time-frequency masking
(ICABM)."
=>
NEW:
"   Like the binaural model described in section 2.2,
the ICA with time-frequency masking is proposed
by Wang et al. who were motivated by human
auditory phenomenon in which a sound is rendered by
louder sound within critical band[3]. The mask M(n,k)
in time-frequency domain is expressed as
               1    if  S_1(n,k)-S_2(n,k) > \theta
   M(n,k) =
               0    otherwise
where $n$ and $k$ stand for indexes of time and frequency,
and $S_1(n,k)$ and $S_2(n,k)$ stand for spectral components
for the target and interference signals.
Because $M(n,k)$ has binary weights, this method can be called
as ICA with binary masking. The threshold $\theta$ is set
to 0 corresponding 0dB."


11) Insert the following between 2. and 2.1 on p.2, right column.
NEW:
"Following three methods which can be used for signal enhancement task using
binaural inputs are examined in this paper.

12) p.2, right column to p.3 left column
OLD:
"This paper present both computational
simulation and experiment to provide data.
The data from computational simulation are
obtained by mixing two original sources signal
using Head Related Transfer Function
(HRTF) of dummy head. The head mix
recording simulation was made using program
obtained from [5]. Then, the surrounding
noise also was added to each channel
as addition data. The last data come
from recording sounds experiment in anechoic
room. As figured out in Fig. 1, the
target sound comes from 0o and the interfering
noise is emitted from －45o. The dotted
line shows the direction of sound sources to
dummy head. The distance between dummy
head and target signal is 1 m.
The recording process from experiment
can be shown in Fig. 3. The experiment
was conducted using dummy head or head
and torso simulator to record the mixed tar-
get and noise sounds in anechoic room. The
data were directly obtained as two wav files
to be inputed to the algorithms. The wav
files are sampled 44100 Hz, 16 bits PCM.
The data then were downsampled from original
sampling frequency to 16000 Hz for
faster computation. Both simulation and experiment
data are used in three algorithms
as described in section 2."
=>
NEW:
 << Because you omit the results of simulation,
   it is better omit the condition of simulation as well.
   Thus reference [5] also is not necessary.
   And the distance, 1m,  of HATS and loudspeakers are
   too short. There are near field effect in this distance.
   You need to put loudspeakers at least at least 1.5m from
   HATS.>>

"Experiment is performed under the setup shown in Fig.1.
Two loudspeakers are located in the direction of $0^\o$
and $-45$\o" of a head and torso simulator (HATS) as shown in Fig.2.
The target signal is female speech where white noise is
used for interference. The level of interference is set to
the same level of target signal at the loudspeakers' positions.
Although observed signals by microphones of HATS are
recorded in 44.1 kHz sampling with 16 bit resolution of PCM,
signals are down-sampled at 16 kHz because a major interest
as the target is speech. "


13) Move Fig. 4 just below Fig.3, or at least put Fig.4 in
 the same page of Fig.3.

14) Caption of Fig.3
OLD:
"Fig 3: Waveform of experiment data"
=>
NEW:
"Fig 3: Signals observed in the  experiment"

15) p.3, right column, lower part.
OLD:
"4 Result
The results for both simulation and experiment
data was presented mainly in comparison
of coherence. Three data from simulation,
simulation with surrounding noise
and experiment were used in three different
methods. In the PDCW method, the
changes of the ITD threshold from 0.2 to
0.3; 0.4; 0.5; 0.6 and 1.0 make improvement
based on listened enhanced sound and waveform
of signal. Perceptually, noise in mid
frequency range is reduced by PDCW and
the quality is between FastICA and ICABM.
In the second method, FastICA algorithm
which previously used in instantaneous mixture
was applied directly to real convolutive
mixture. In this method, there are points
to exceed the maximum and those produce
the many noise in output signal. However,
result of FastICA algorithm for experiment
are best based on coherence criterion. Finally,
ICA with binary masks is applied to
the data to provide fair comparison using
coherence criterion. We can see in Fig. 3
in which the waveform of ICA with binary
mask as adopted from [4] is similar to target
but it has low coherence. The result of
ICABM can minimize interfering noise and
remains target signal, but the sound quality
is degraded as can be seen by its spectrogram
in Fig. 4. That figure shows the comparison
of spectrogram signals from experiment
data while Table 1 shows the different
coherence among three methods."
=>
NEW:
"4 Results of Experiment
  Figure 3 shows the observed signals as waveforms
where Fig.4 shows the spectrograms of those signals.
The order of plots in those figures are, from top,
target signal, observed signal at left ear position,
one at right, enhanced signal by the binaural model (PDCW)
mentioned in 2.1, one by Fast ICA in 2.2, and one
by ICA with binary masking (ICABM) in 2.3.
Note that ICABM method utilizes the binary mask adopted
from [4]. Also Table 1 shows the averaged coherences between
the target signal and each of three enhanced signals.
In this Table, results of simulation are also provided
for the comparison
  According to preliminary subjective evalution,
noise in mid frequency range is reduced by PDCW and
the sound quality of PDCW seems to be among FastICA and ICABM.
FastICA provide the best according to the coherence criterion.
ICABM provides fair performance according
to the spectrogram and coherence criterion.
Although the waveform of ICABM seems to be similar to target signal,
it has low coherence.
ICABM minimizes interfering noise and remains target signal,
but the sound quality is degraded as can be seen by its spectrogram
as in Fig. 4. "

16) Table 1.
Remove uncertain digits;
New:
"PDCW   0.79 0.28
FastICA 0.77 0.35
ICA +BM 0.37 0.28"

17) Width of spectrogram in Fig. 4 should be the same
  as the waveform of Fig.3 in order to compare them.
  Please stretch the width of spectrograms in Fig.4
  according to Fig.3.

18) p.4 left column (conclusion)
OLD:
"The future work should be addressed
the different result between simulation
and experiment. How to compensate
the gain and latency in experiment must be
included in simulation to close the real problem.
In other side, another method like in
[6] can be compared to achieve low and fast
computation and ready to be implemented
such as in [7]."
=>
NEW:
"As the future works, the various conditions of
 signals not only arrangements as well as types of
 signals need to be examined in order to make clear
 the characteristics. Beside three methods examined
 in this paer, it is necessary to compare other methods
 such as [6] which is ready to implemented as [7]."

If you have space, please make Fig.3 and Fig. 4 as the
double column.

19) Caption of Fig.4
NEW:
"Fig 4: Spectrograms of observed signals in experiment"

Looking forward to having your revised draft.

Yours,  
tuie @ Haneda on the way to Narita.

---  
Dear Mr. Bagus,

sorry but I will leave from Network for 8 hours
since now.
So, please check your document by yourself again and
submit it within TODAY via e-mail first.
And the post the printed one tonight at local post office or
mail box on the street.

Yours,  
tuie

PS Have a nice rest after you submitted.

---  
Dear Sensei,

Thank you very much. Ok I will send the paper by today and forward to you.

---  
Dear All Sensei,

Below is link of my paper for ASJ Kyushu, Oita. 

https://xxx

---  
Dear Mr. Bagus,

thank you for your information.
I got your e-mail in Ho Chi Minh city, Vietnam.

After take a rest, please make a simulation again
under specified signal to interference ratio.

Yours,  
tuie

---  
Dear sensei

I uploaded my poster draft for ASJ Kyushu student meeting here,
>
> https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111116110627/bta_asj_kyushu_90x180.pdf

I am looking forward to having your review and thanks for your advices.

---  
Dear Mr. Bagus,

the contents of the sent poster is basically fine.

However you need to think about the poster venue's situation.
If the venue is crowded and you can not look a lower part of
the poster, you can find out attractive posters with out
reading the lower part of poster?

If you can not understand this comments, please contact M2 students
who had poster presentation before hand.

Yours,  
tuie

---  
Dear Mr. Bagus,

please send the email to HICC-ALL.
you are one of the authers as well as I am.
You need to share all the activities with co-authers at least
in the lab.

1)
What is ICABM in results and conclusion?
Where you have defined?

2)
Labels of spectrograms and waveforms are visible?

3)
What is input SNR for simulation and experiment?
(You need to show those experimental condition in the poster
  otherwise the data are meaningless because we can not
  compare the values of simulation and experiment.)

4)
In the figure of experimental setup, the origin of source angle
should be the center of head, not nose position.
And please note that 1.0m from the HATS to loudspeakers is
in the near field condition as the HRTF. That means
the condition can not be simulated using ordinary HRTF database
such as MIT media labo's, Nagoya University's one and others.
(You need to know this mis-match between simulation and experiment.)

5)
Why your file is more than 30Mbyte?
(From Indonesia, I will not able to access this kind of file size.
  Waveforms should be rasterized before including the poster.)

Yours,  
tuie

---  
Dear Mr. Bagus,

 >> 1)
 >> What is ICABM in results and conclusion?
 >> Where you have defined?
 >
 > I add result of ICABM in conclusion. The result is perceptually good as well as shown by waveform.

You did not understand my comment.
How the reader understand
    ICABM is ICA with binary mask
without any information.

 >> 3)
 >> What is input SNR for simulation and experiment?
 >> (You need to show those experimental condition in the poster
 >> otherwise the data are meaningless because we can not
 >> compare the values of simulation and experiment.)
 >
 > The input is 18 dB. I remove the result of simulation because of mis-match between simulation and
experiment.

If the input SNR is 18dB, you need to write this information in your poster.

Why you don't make a simulation results for SNR=18dB and add the information on this
poster?

You can make it because there are 4 days for presentation.


Yours,  
Tuie @ on the way to Bali, via Narita.

---  
Dear Sensei,

Now, I understand what you meant. I make abbreviation without prior explanation. I will mention it on section 2 in poster. I will make simulation tonight and includes the result in poster.

Thank you for your correction.

Kind regards,  
bta

---  
Dear Mr. Bagus,

thank you for your prompt reply.
Thank you indeed and looking forward to having your
revised poster.

Yours,
tuie

PS  Because I will fly to Bali via Jakarta tomorrow thus
   I may not able to access the internet continuously.
   About the research plan, I will reply hopefully before
   boarding to the flight to Jakarta (CGK).
  
---  
Dear sensei,

I revised my paper here,
https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/111121142702/oita_poster_bta.png

I show the averaged coherence in three numbers after coma to show the different.

Regards,  
bta

---  
Dear Mr. Bagus,

for the next time, please use PDF (not image)
because the quality of enlarge image is not good enough to read.

The revised poster is fine with what I have mentioned except the
position of conclusion.
However, you can print as this format if you think it is OK.

Beside this poster, I am little bit confusing that
   ICABM's BM seems to be abbreviation of "Binary Masking" in the
poster, but your research plan, you use "Binaural Masking."
Which is what you have used and what you will use?

Anyway, the poster seems to ready to print. Have a nice trip
to Oita on 25th and see you on Oita Univesity's venue on 26th Nov.

Yours,   
tuie

---  
Dear sensei,

Thank you for your reply.
I will finalize my poster according to your advices, especially for conclusion and abbreviation of ICABM. Then I will print it.

I mean BM is refer to binary mask, the ideal binary mask proposed by DL Wang.

---  
Dear Mr. Bagus,

explain the details of "FastICA with Binaural Masks" which part of it
comes from which references and which part is your original work?

And why you can say that FastICA + Binaural Masks work well?
Explain the basic idea of this algorithm.

Also, please make clear the concrete experimental conditions
and how long the total experiments takes?

Looking forward to having your reply.

Yours,  
tuie

PS  I will be in Bali during 22-25 Nov. and I can not access
the internet on 21st due to flight from Tokyo to Bali via Jakarta.

---  
Dear sensei,
> explain the details of "FastICA with Binaural Masks" which part of it
> comes from which references and which part is your original work?
>
Reference: FastICA by Hyvarinen et al.

Me: The use of binaural mask after FastICA or the integration of fastica with binaural mask.


> And why you can say that FastICA + Binaural Masks work well?
> Explain the basic idea of this algorithm.

I can't say at this time, but I assumed it will work. The output FastICA remains noise, by using binaural mask, I hope it can be obtained enhanced signal that good in both numerical criterion and perceptually listened sound.

> Also, please make clear the concrete experimental conditions
> and how long the total experiments takes?

Actually I need your advices to design my experiment. As first, I propose combinations of experimental conditions below,

Distance: 1.4; 1.5; 1.6 m  
Interference: 1 interference and 2 interference  
Elevation: 0' , 30' and - 45'  
Azimuth : 45, -30, 0, 30, 45  
SIR= 18 dB, 10 dB, 0 dB, -10 dB, -18 dB  
SNR additive noise = 20 dB and 30 dB  

Maybe it takes one week, once or twice measurement.
Looking forward for directions from both of you, and thank you for your advices.

Best,   
bta

---  
Dear Sensei,

Thank you for your reply and interest.
1. I will show the result as chart and diagram in thesis book and paper
2. On thesis book and paper, I will show three significant digits only.

Here are my schedules for next two months:  
January 1st week : Writing Thesis  
January 2nd week : Experiment, Writing Thesis and Paper  
January 3rd week : Finalizing Thesis  
January 4th week : Go to Indonesia, Thesis Seminar (open) and Thesis defense (close)  
February 1st week : Thesis revision, Writing paper, Paper submission  
February 2nd week : Fulfill graduation requirements, Paper revision  
February 3rd week : Fulfill graduation requirements, obtain Master Degree certificate if possible  
February 4th week : Conference in Brawijaya University, Back to Japan  

About the conference, I only found the following, SciETec 2012 (Science, Engineering and Technology Seminar 2012) to make presentation
http://www.scietec.ub.ac.id
That is annual seminar for graduate student in Brawijaya University, Malang City (very close to Surabaya, also big University). The paper can be written in English although most of the participants are Indonesian.The deadline is February 7th and the conference will be held on February 23-24, 2012.
I already book the ticket to Surabaya on January 22th (booked by Mrs. Mia when
I planned to go to Japan-vv) but I need support to come back to Japan. If you
allow me to attend that conference, I must leave Japan more than a month (I
plan to directly back to Japan after the conference). Based on my experience
when graduation on bachelor degree, it needs almost a month to fulfill the
graduation requirements. So, the conference date meet my schedule. However, I
need your decision to allow me or not to stay outside Japan more than a month
(in relation to my Jasso scholarship). I plan to back to Japan on February 25th
after attending the conference.

---  
Dear Mr. Bagus,

Because of my boarding to Tokyo is started. I will reply until
tomorrow morning.

Yours,  
tuie

---  
Dear Mr.  Bagus,

Followings inline comments are my comments on your plan.

(2011/11/20 15:57), Bagus Tris Atmaja wrote:
> Dear Sensei,
>           cc DA
>
>> explain the details of "FastICA with Binaural Masks" which part of it
>> comes from which references and which part is your original work?
>>
> Reference: FastICA by Hyvarinen et al.
>
> Me: The use of binaural mask after FastICA or the integration of fastica with binaural mask.

Ok, then who propose the binaural mask? Is it yours?
If not, still it is OK if nobody check the combination. Just
I want to make clear.


>
>
>> And why you can say that FastICA + Binaural Masks work well?
>> Explain the basic idea of this algorithm.
>
> I can't say at this time, but I assumed it will work. The output FastICA remains noise, by using binaural mask, I hope it can be obtained enhanced signal that good in both numerical criterion and perceptually listened sound.

Thus you are not yet confident whether FastICA + Binaural mask works well or not.
In this context, I suggest you check "systematically varied conditions" for
   FastICA
   FastICA + Binaural Mask
as well as
   PDCW
   ICA
   ICA + Binaural Mask

Note that the word "systematically varied" is key.


>
>> Also, please make clear the concrete experimental conditions
>> and how long the total experiments takes?
>
> Actually I need your advices to design my experiment. As first, I propose combinations of experimental conditions below,
>
> Distance: 1.4; 1.5; 1.6 m
There is no reason to change the distance if SNR/SIR at source is given in
anechoic chamber.
Using HATS, you need to make an experiment more than 1.5m from the center of
HATS, thus 1.6m is fine as well as 1.5m, but not 1.4m.



> Interference: 1 interference and 2 interference

> Elevation: 0' , 30' and - 45'
Can you setup such a large elevation, +30deg or -45deg in the experimental setup?
Make clear image of realistic setup.

If the hight of HATS is 1.7m for example, ear position will be 1.6m or so.
At 1.5m,  +30deg means 1.5 sin(30deg) + 1.6 = ??? Do you any one who has such
a hight? As well as for -45deg,  1.5 sin(-45deg) + 1.6 = ???  You assume
a baby?


> Azimuth : 45, -30, 0, 30, 45
Why not include ±15, ±60, ±75, ±90

> SIR= 18 dB, 10 dB, 0 dB, -10 dB, -18 dB
Why not 20dB instead of 18dB.
(The previous experimental results is not necessary to use.)

> SNR additive noise = 20 dB and 30 dB
If you will set SNR as Target Signal against ambient noise, those two
seems fine.


> Maybe it takes one week, once or twice measurement.
Before performing experiments, you need to make a computer simulation
through out the condition. Then you can find out necessary conditions
to confirm the feasibility of simulation results.

Please provide the simulation results as soon as possible to cover
the above mentioned condition. Note that if you use HRTF catalog, you
do not pay attention about the distance between sensors and sound source.


Yours,  
tuie

---
Dear Sensei,

Here my reply,
1.  No, not from me. I will use binary mask (I am sorry, not binaural mask) proposed by DL Wang et al. and integrating it with fastica. I have checked it, and as long as I know no one propose it.
2.  Ok, I will make "systematically varied" as the key.
3. Thank you, I will use 1.6 m for experiment.
4. I think 30'  and -45' are sound from such as airplane, vacuum cleaner and others. Anyway, I will change to +5, 0 and -5 for elevation. are those ok?
5. So the elevation are, ±90, ± 75, ±60, ±45, ±30, ±15, 0
6. SNR (target vs ambient noise): 20 dB and 30 dB

From DA, he suggest me to use high sampling frequency to reduce spatial aliasing, and also as novelty of this research. Then we can downsampled according to our necessity.

---  
Dear Mr. Bagus,

Pls read
http://www.kecl.ntt.co.jp/icl/signal/sawada/mypaper/icassp2005sawada.pdf
and his and his colleague's papers.

Also read Prof. Saruwatari's papers on IEEE and IEICE.

/YC

---  
Dear Mr. Bagus,

thank you for your reply.
1, 2, 3 would be OK.
About 4, if you assume the noise such as one from vacuum cleaner or airplane,
you need to use such sound. In case of airplane noise, you need think about the
reflection from the ground because airplane noise from +45 in elevation is
assumed to be observed outdoor.

Please make a design of simulation first and get the results of simulation
first. Then you are ready to make experiments on the specific conditions
which you really need to show the differences between the conventional
methods and your combined method.

About the sampling frequency,  Peking University provide 96kHz sample HRTF
database but it is not so popluar in the society. If you use HRTF provided
by Nagoya University, sampling frequency is 48kHz (as far I remember).
Thus, at this moment, I suggest to use 48kHz if you want to use higher
sampling frequency.

If you are going to use two microphone array without head, the characteristics
of directivity of ICA are deeply investigated and there are several interpretation
but the most straight forward interpretation is that ICA provides the automatic
directivity control based on the characteristics of sound environment.
However, there are strong restriction about the number of independent sound
sources and number of independent inputs (number of sensors).

Looking forward to having your simulation plan.

Yours,  
tuie@ TENCON2011 venue in Bali, Indonesia

---  
Dear Sensei,

About elevation, how about a slight different degree because we will use available sound sources such as female, male speech and white noise. So I think its better to make a slight different degree such as +- 10' and 5. If the height of target 1m so the height of interference will be 1.28 cm and 1,13 cm  (for 1.6 m distance).

For sampling frequency, I will 48kHz as you suggested.

About the microphones, I will use microphone in HATS. But I see that our
recorder (Roland R44) has two built in microphones, maybe I can use it as
additional data.

---  
Dear mr. Bagus,

If  you use builtin microphone, can  you  make a simulation before hand? Are you going to messure transfer function of buildin microphone?

Tuie from bali.

---  
Dear sensei,

Thank you for your correction. It is better for me to use microphones on HATS only because HRTFs are available.

---  
From Sensei:  
One comment from me at this moment is that
    please remind the diffraction of head which
    plays  very large roles for ITD and ILD.
(This means that if you use two microphones without
   "object" which provides diffraction, ITD and ILD
   are rather simple and very weak frequency dependency.)

Effect of Over sampling to spatial aliasing
- the microphone space is set to wide and wider with higher sampling frequency  
	4 cm	-->	8000 Hz  
	8 cm	--> 11025 Hz  
	12 cm	-->	22050 Hz  
	16 cm	-->	44100 Hz  
- proposed method : Subband Adaptive filterbank


-sensei:  
Menambahkan Gammatone Filter pada FDBM


OLA=overlapped add

---  
Dear sensei,

I put our draft for SciETec 2012 in UB on the following link,

https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/120128173744/SciETec2012_v1.pdf

---  
Dear Mr. Bagus,

please check the following things before submit the paper
to the committee.

1) Put the reference for PESQ definition.
   (You have referred Ms. Tomita's paper, but you need to
    refer the original PESQ reference as well. Both are necessary.)

2) Significant digit for coherence as well as PESQ, SIR can no be
     4 or more because if you change part of the same data,  numbers
     you have shown would be changed.
    For coherence,  it may be something like 0.89 (two digits before decimal
    point.)
    Also for PESQ,  2 digits are enough and 3 digits are at most like
     1.9 or 1.94
    For SIR in dB,  2 digits below decimal point are at most.
    Most of dB number below 2nd digit below decimal point,  0.01, is not
    significant for actual data processing.
    (If you change the data length such as first half of signal, you may
    have hard time to get the same numbers.)

3) Put the line break before second = in Eq.(6) and Eq.(7).


FYI,  I will be ITS on Thursday & Friday of this week.  
Yours,   
tuie

---  
Dear Sensei,

Thank you for your directions. I will make revision based on your suggestions.
Because the committee only accept .doc file, I will convert the it to doc file.

Yoroshiku Onegai Shimasu,  
bta

---  
Dear Sensei,

I am very sorry just to inform you my progress now.
My paper in ScieTEc 2012 was rejected due to the following reasons.
Format: not match
Topic: not match
Then, I submit our paper to Basic International Conference 2012 and got the acceptance.

---
Dear　Mr. Bagus,

thank you for your information.

About ScieTec 2012, it is OK if the committee rejected.
And for Basic 2012, congratulation and please enjoy your
presentation as well as the conference itself at UB.

By the way, the defense for your Master Thesis is successfully
finished?
I hope everything works very well with you.

Yours,
tuie from still cold Kumamoto

PS Yesterday, we have a part for cerebrating the successful
    finish of All Master defense and Bachelor defenses.

---  

Wed, Feb 22, 2012, 7:40 PM
to tuie

Dear Sensei,  

I finished my thesis defense and tomorrow the result will be announced (actually it should be announced on the last week but it was delayed because ITS file server is down). The most exhausting thing is about to fulfill the graduation requirement.
However, I will back to Japan on tuesday 28 and I ask my friend here to process my master degree certificate.

---  
Dear Mr. Bagus,  

thank you for your information. I am glad that you finish your
defense successfully and waiting for the certificate.

Enjoy your conference and Surabaya until you leave.

Yours,  
tuie

---  
Dear Sensei,  
 
Today, it is annouced that I am granted as master degfree of Engineering Physics.
Thank you for your guidance and see you in Kumamoto.
 
Yoroshiku onegaishimasu,   
bta

---  
Mr. Bagus,  

congratulation indeed!
Thank you for your e-mail and please enjoy your visit Malang.

Yours,  
tuie

---  
Dear Sensei,  

I would like to submit my JASSO final report. The current file saved as
https://www.hicc.cs.kumamoto-u.ac.jp/uploads/private/120309141332/Bagus_JASSO.pdf
I am waiting your suggestion for improvement before I submit to the GSST-JASSO.

Yoroshiku onegaishimasu,  
bta

---  
I got your progress report and it seems interest to me.
However, in order to write the thesis as well as for the defense,
I suggest the followings.

1) Make graphical representations for the data.

2) Significant digits for coherence and PESQ are correct?
   (If you change the condition little bit, are they still stable
    for all digit?  Do you think that 0.01 difference of PESQ is
    perceptible for human being?)

About the trip back to ITS, please let me know your detail schedule
and when you book the ticket, please let me know.
(If there is any conference/Seminar in Surabaya or near Surabaya, and if
  you can make a presentation, it might be interesting.)

Anyway, have a nice new year holiday in COLD Kumamoto. (I hope you can
survive!)

---  
Dear Mr. Bagus,

thank you for your final report of the JASSO program.
I think it is bit long but it will work, so please
submit it GSST. (In case they said to reduce the number of
pages, I will suggest to you to reduce the research part.)

Anyway, thank you for your work.

Yours,  
tuie

---  
