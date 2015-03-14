# Basic Installation Instructions #

Please email [fwhigh@gmail.com](mailto:fwhigh@gmail.com) if you download SLR so we know who you are, and so we can put you on the mailing list for SLR updates.

First, go get the latest version 2 download at http://code.google.com/p/stellar-locus-regression/downloads/.  Untar it with `tar xzvf slr-v2.1.tar.gz`.

Put the package in some directory `<install-dir>`.  This can be `/usr/local/idllibraries` or `$HOME` or whatever you prefer.  The package root directory will then be `<install-dir>/slr-v2.1`.

Version 2.1 and higher require only IDL, and _do not_ require Analyst.  Version 2.0 and prior require IDL with the Analyst add-on, which costs extra.

## Quick Install ##

  * Install and set up the Goddard astronomy IDL libraries, idlutils, and the Markwardt IDL libraries.
  * Install and set up the Schlegel, Finkbeiner, and Davis (1998) E(B-V) dust maps and IDL utilities.
  * Download the stellar locus data of Covey et al. (2007) and put them in a directory `<data-dir>/covey`.
  * Issue (in tcsh):
```
setenv SLR_INSTALL <install-dir>/slr-v2.1
setenv SLR_DATA <data-dir>
setenv PATH {$PATH}:$SLR_INSTALL/bin
```
  * Go to "Test Your Installation" below.

## Full Install ##

### IDL Libraries ###

You'll need these idl libraries:
  * idlutils: http://www.astro.princeton.edu/~schlegel/code.html (any installation procedure will do, but you probably want the latest idlutils tar file, e.g. idlutils-v5\_3\_0.tar, this includes the Goddard astronomy libraries)
  * Goddard astronomy libraries (see above)
  * Markwardt: http://www.physics.wisc.edu/~craigm/idl/ (you want cmtotal.tar.gz)

Put them in your typical IDL directory.  For example, use a directory you can remember `<pro-dir>`, like `/usr/local/idllibraries`.

Don't forget to add them to your `IDL_PATH` with shell startup file entries similar to:
```
IDL_PATH=$IDL_PATH:+<pro-dir>/idlutils:+<pro-dir>/markwardt
export IDL_PATH
```
in bash or
```
setenv IDL_PATH {$IDL_PATH}:+<pro-dir>/idlutils:+<pro-dir>/markwardt
```
in tcsh.

Of course all of this assumes you have properly initialized the `IDL_PATH`, for example in tcsh:

```
setenv IDL_BIN /usr/local/itt/idl/bin
source $IDL_BIN/idl_setup
setenv IDL_PATH \<IDL_DEFAULT\>
```


### Galactic Dust Maps ###

SLR in effect uses dust maps located in `$DUST_DIR/maps` to get Schegel et al. (1998) dust values.  Here's how to set this up.

Go to http://astro.berkeley.edu/~marc/dust/data/data.html to get the dust maps and IDL code.  Follow their install instructions.  You only need the high resolution 4096 E(B-V) maps, both the north and south Galactic planes (NGP and SGP).  Put them in some directory, for example `<install-dir>/slr-v1.0/example_data/sfd/maps`.  **Make sure the top directory is maps and not map.**  Put the SFD IDL code in some `<pro-dir>` and add to IDL\_PATH.

As instructed at the website, set the `DUST_DIR` environment variable.  If you used our suggestion, then you would issue
```
setenv DUST_DIR <install-dir>/slr-v2.1/example_data/sfd
```
The directory `$DUST_DIR/maps` must exist and contain the E(B-V) dust maps.


### The Standard Stellar Locus ###

SLR gets the standard stellar locus data from the directory `$SLR_DATA/covey`.

Go get Kevin Covey's stellar locus data, which he makes available on his own website.  You'll need the stellar data:

http://www.cfa.harvard.edu/~kcovey/research/superclean.fits

and the median locus line data:

http://www.cfa.harvard.edu/~kcovey/research/medianlocus.tbl

Put them in some directory `<data-dir>/covey`.  We suggest putting them in the `<install-dir>/example_data/covey` subdirectory of your installation.  Set `SLR_DATA`.  If you used our suggestion, then you would issue
```
setenv SLR_DATA <install-dir>/example_data
```
The directory `$SLR_DATA/covey` must exist and contain `medianlocus.tbl` and `superclean.fits`.


### SLR Environment Variables ###

Now set some environment variables in your cshrc or bashrc file.  Remember to insert the appropriate directories.  Example is for tcsh:
```
setenv SLR_INSTALL <install-dir>/slr-v1.0
setenv SLR_DATA <data-dir>
setenv IDL_PATH {$IDL_PATH}:+$SLR_INSTALL/pro
setenv DUST_DIR $SLR_DATA/sfd
setenv PATH {$PATH}:$SLR_INSTALL/bin
```

We've used the example directories mentioned in this install file.  This should let the demo (see below) work properly.  If you made different choices, you must make sure these environment variables reflect them.


## Test Your Installation ##

### 1: Make the Documentation ###

To check that everything is working (don't forget to source your rc file), fire up IDL and then make the SLR documentation web page with
```
IDL> slr_docs
```
This will make the SLR IDL help page `$SLR_INSTALL/docs/www/idl_help.html`, which you can open in a web browser.

### 2: Run the Standalone Executable ###

Go to the directory `$SLR_INSTALL/example_data`, then issue at the commandline (do you need to `rehash`?):
```
slr.csh lowext_stars3_fwhigh.ctab lowext_stars3_fwhigh.slr.ctab
```
This will run SLR on the example colortable we provided (first argument), and output SLR calibrations to another colortable (second argument).  The output colortable is equal to the input colortable but with the additional appended columns `GR`, `RI`, etc, which are the calibrated colors _g - r_, _r - i_.  Estimated color errors, with bootstrap errors added in quadrature, are also output.

Browse the log file that SLR generates, in this case `lowext_stars3_fwhigh.slr`.  This contains the color calibrations with bootstrap errors.


### 3: Run from Within IDL ###

Now that you've run the commandline version of SLR, try doing SLR from within the IDL environment.  Go to the directory `$SLR_INSTALL/example_data`, fire up IDL, and run our demo script,
```
IDL> slr_demo
```
The first time you run it, it will take some time (it's reformatting the data to an optimal, IDL-friendly format).  It will be faster the second time.

The demo will run SLR on the example Sloan Digital Sky Survey data that comes with your installation.  You should see plots of the stellar locus (you must hit enter to continue), a visualization of the numerical regression, and results for best-fit parameters printed to screen.