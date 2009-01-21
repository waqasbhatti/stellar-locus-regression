pro slr_demo

;+
; NAME:
;  slr_demo
;
; PURPOSE:
;  Demonstrate the SLR package out of the box.
;
; EXPLANATION:
;  Uses data in example_data.  Requires a proper installation to run
;  successfully. 
;
; CALLING SEQUENCE:
;  slr_demo
;
; INPUTS:
;
; OPTIONAL INPUTS:
;
; OUTPUTS:
;
; OPIONAL OUTPUTS:
;       
; NOTES:
;
; EXAMPLES:
;
; PROCEDURES USED:
;       
; HISTORY:
;       Written by:     FW High Jan 2009
;
;-


;;; Get global default options, then set some of your own.
option=slr_options()
option.plot=1
option.postscript=0
option.interactive=1
option.use_ir=0
option.verbose=1

;;; Get global default hard limits on the data
limits=slr_limits()



message,'Regressing high extinction data',/info

;;; Initialize data with low Galactic dust extinction
slr_get_data,$
   fieldname='lowext_stars3_fwhigh',$
   option=option,$
   limits=limits,$
   data=low_dust_data

   
;;; Regress the data to the Covey median locus
slr_locus_line_calibration,$
   data=low_dust_data,$
   option=option,$
   kappa=low_kappa,$
   kap_err=low_kappa_err,$
   galext_mean=low_galext_mean,$
   galext_stddev=low_galext_stddev


print,'Best fit kappa'
print,' kappa(g-r) = ',string(low_kappa[0],format='(F6.3)'),$
   ' +/-',string(low_kappa_err[0],format='(F8.5)')
print,' kappa(r-i) = ',string(low_kappa[1],format='(F6.3)'),$
   ' +/-',string(low_kappa_err[1],format='(F8.5)')
print,' kappa(i-z) = ',string(low_kappa[2],format='(F6.3)'),$
   ' +/-',string(low_kappa_err[2],format='(F8.5)')
print,'Compare to predicted Galactic extinction values'
print,' E(g-r) = ',string(low_galext_mean[0],format='(F6.3)'),$
      ' +/-',string(low_galext_stddev[0],format='(F8.5)')
print,' E(r-i) = ',string(low_galext_mean[1],format='(F6.3)'),$
      ' +/-',string(low_galext_stddev[1],format='(F8.5)')
print,' E(i-z) = ',string(low_galext_mean[2],format='(F6.3)'),$
      ' +/-',string(low_galext_stddev[2],format='(F8.5)')
      


message,'Regressing high extinction data',/info

;;; Initialize data with high Galactic dust extinction
slr_get_data,$
   fieldname='hiext_stars3_fwhigh',$
   option=option,$
   limits=limits,$
   data=high_dust_data

;;; Regress the data to the Covey median locus
slr_locus_line_calibration,$
   data=high_dust_data,$
   option=option,$
   kappa=high_kappa,$
   kap_err=high_kappa_err,$
   galext_mean=high_galext_mean,$
   galext_stddev=high_galext_stddev

print,'Compare to predicted Galactic extinction values'
print,' E(g-r) = ',string(high_galext_mean[0],format='(F6.3)'),$
      ' +/-',string(high_galext_stddev[0],format='(F8.5)')
print,' E(r-i) = ',string(high_galext_mean[1],format='(F6.3)'),$
      ' +/-',string(high_galext_stddev[1],format='(F8.5)')
print,' E(i-z) = ',string(high_galext_mean[2],format='(F6.3)'),$
      ' +/-',string(high_galext_stddev[2],format='(F8.5)')
      




end
