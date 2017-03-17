# MADpatterns
[![DOI](https://zenodo.org/badge/72135256.svg)](https://zenodo.org/badge/latestdoi/72135256)

## Description

**MADpatterns** is a tool to **M**odel and **A**nalyze  1**D** **patterns** using the software MATLAB, that was developed in the lab of Prof. Nancy Kleckner at Harvard University
http://projects.iq.harvard.edu/kleckner_lab

#### Key Features

1. Quantitatively model 1D patterning events based on the Beam-Film model for crack formation
2. Automate analysis of 1D patterns

## Installation
Download program, unzip the folder, open MATLAB and add the unzipped folder to the file path

## Usage
For a detailed user guide and information on the relevance of this program to the study of meiotic recombination events, please read our manuscript currently available on bioRxiv and soon to be available in Methods in Molecular Biology.

doi: http://dx.doi.org/10.1101/083808

Update: A new function has been added to the program in order to model the effect of a reduced number of active precursors (parameter Y).  For more information on this parameter, please read our new paper:

Wang et al. (2017). Inefficient Crossover Maturation Underlies Elevated Aneuploidy in Human Female Meiosis. Cell; 168: 977 - 989

In order to incorporate this new function, the input table for simulating 1D patterns according to the Beam-Film model has been updated.  The appropriate format of this input table can be found in the example table (simulation_parameters.csv) that is included with the program.

## Known Bugs
The simulation part of the program will fail to execute if a set of input parameters is used that leads to no simulated object receiving any precursor

## Credits
This program was developed by Martin White in the lab of Prof. Nancy Kleckner with help from Liangran Zhang.  A significant fraction of this program is either directly taken or derived from a previous program developed by Liangran Zhang, Nancy Kleckner and John Hutchinson:

Kleckner et al. (2004). A mechanical basis for chromosome function. Proc. Natl. Acad. Sci. USA; 101: 12592 - 12597

Zhang et al. (2014). Crossover patterning by the Beam-Film model: analysis and implications. PLoS Genetics; 10: e1004042

Zhang et al. (2014). Topoisomerase II mediates meiotic crossover interference. Nature; 511: 551-556.

This previous version of the program is available for download here https://app.box.com/s/hv91q2nrtq0cp9n8iy9m

## License
MIT License

Copyright (c) 2016 Martin Andrew White

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
