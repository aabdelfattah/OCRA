# OCRA : OCR for Arabic Cursive Text

A very basic implementation of Arabic OCR using MATLAB, it uses HMM for learning and recognition.

## To run the application 

- Add all the folders and subfolders to MATLAB Path.
- From the current directory type : main in MATLAB cmd window

## Parameters

- To change number of runs : modify NUM_RUNS in main.m
- To choose Sliding window technique pass 1 to OCRA2() in main.m
- Some parameters are available in OCRA2.m
	- TRAINING_SAMPLES = 20 ;  % number of pictures used for training per symbol(letter)
	- EVAL_SAMPLES = 2;  % number of pictures used for evaluation per symbol(letter)
	- NUM_LETTERS = 28; % number of symbols (letters)
	- NUM_STATES = 5;	  % number of states in a HMM symbol model

## Application Hierarchy

- **letter.m** : LUT maps between symbol string and symbol number for convenience
- **load_training_data.m** : loads BOTH training and evaluation data for direction sequence technique 
- **load_training_data_sw.m** : loads BOTH training and evaluation data for sliding window technique
- **Sliding2.m** : extracts sliding window feature vector
- **OCRA2.m** : OCR training, recognition and error evaluation
- **main.m** : top level module
- **OCRA29062014.pdf** : project documentation

## Directory

- **SW** : contains sliding window training data and evaluation data(.png) in a subdir eval in each letter dir
- **set n**  : contains direction sequence training data and evaluation data(.txt files) in a subdir eval in each letter dir

currently set 3 saad is used

## Disclaimer 

This implementation was a part of a graduate course project and actually it achieves very poor result, you can't rely on it for any real OCR but it will be useful as a starting point to learn from and build on.

## Contribute

- Fork project
- Add features
- Run tests
- Send pull request

## License

See LICENSE file for details
