# Basic Installation Instructions #

First, go get the version 1.0 download at http://code.google.com/p/stellar-locus-regression/downloads/.  Untar it with `tar xzvf slr-v1.0.tar.gz`.

Put the package in some directory `<install-dir>`.  This can be `/usr/local/idllibraries` or `$HOME` or whatever you prefer.  The package root directory will then be `<install-dir>/slr-v1.0`.

To get things running, right now you need IDL 7.0 with Analyst.  Plans to be rid of the Analyst-dependence are in the works.

## Quick Install ##

### IDL Libraries ###

You'll need these idl libraries:
  * idlutils: http://www.astro.princeton.edu/~schlegel/code.html (any installation procedure will do, but you probably want the latest idlutils tar file, e.g. idlutils-v5\_3\_0.tar, this includes the Goddard astronomy libraries)
  * Goddard astronomy libraries (see above)
  * Markwardt: http://www.physics.wisc.edu/~craigm/idl/ (you want cmtotal.tar.gz)

Put them in your typical IDL directory.  For example, use a directory you can remember `<prodirectory>`, like `/usr/local/idllibraries`.

Don't forget to add them to your `IDL_PATH` with shell startup file entries similar to:
```
IDL_PATH=$IDL_PATH:+<prodirectory>/idlutils:+<prodirectory>/markwardt
export IDL_PATH
```
in bash or
```
setenv IDL_PATH {$IDL_PATH}:+<prodirectory>/idlutils:+<prodirectory>/markwardt
```
in tcsh.

Of course all of this assumes you have properly initialized the `IDL_PATH`, for example in tcsh:

```
setenv IDL_BIN /usr/local/itt/idl/bin
source $IDL_BIN/idl_setup
setenv IDL_PATH \<IDL_DEFAULT\>
```


### Galactic Dust Maps ###

You need the Galactic dust maps and IDL code from the Schlegel et al. (1998), available at http://astro.berkeley.edu/~marc/dust/data/data.html.  Follow their install instructions.  You only need the high resolution 4096 E(B-V) maps, both the north and south Galactic planes (NGP and SGP).  Put them in a location like, `<install-dir>/slr-v1.0/example_data/sfd/maps`.  **Make sure this is maps and not map.**  Put the SFD IDL code in `<prodirectory>` and add to IDL\_PATH.  As instructed at the website, you must set DUST\_DIR.


### The Standard Stellar Locus ###

Go get Kevin Covey's stellar locus data, which he makes available on his own website.  You'll need the stellar data:

http://www.cfa.harvard.edu/~kcovey/research/superclean.fits

and the median locus line data:

http://www.cfa.harvard.edu/~kcovey/research/medianlocus.tbl

We highly recommend putting them in the `example_data/covey` subdirectory of your installation, which will help you get the demo running.


### SLR Environment Variables ###

Now set some environment variables in your cshrc or bashrc file.  Remember to insert the appropriate directories.  Example is for tcsh:
```
setenv SLR_INSTALL <install-dir>/slr-v1.0
setenv SLR_DATA $SLR_INSTALL/example_data
setenv IDL_PATH {$IDL_PATH}:+$SLR_INSTALL/pro
setenv DUST_DIR $SLR_DATA/sfd
```

We've used the example directories mentioned in this install file.  This should let the demo (see below) work properly.  If you made different choices, you must make sure these environment variables reflect them.


### Test Your Installation ###

To check that everything is working (don't forget to source your rc file), make the SLR documentation web page with
```
IDL> slr_docs
```
This will make the SLR IDL help page `$SLR_INSTALL/docs/www/idl_help.html`, which you can open in a web browser.

If that worked, now run the demo with
```
IDL> slr_demo
```
The first time you run it, it will take some time (it's reformatting the data to an optimal, IDL-friendly format).  It will be much faster the second time.

The demo will run SLR on the example Sloan Digital Sky Survey data that comes with your installation.  You should see plots of the stellar locus (you must hit enter to continue), a visualization of the numerical regression, and results for best-fit parameters printed to screen.