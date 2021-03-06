#ifndef _IFFTW_H
#define _IFFTW_H

#ifdef MPI
#  include <fftw_mpi.h>
#  ifdef OPENMP
#    include <fftw_threads.h>
#  endif
#else
#  ifdef OPENMP
#    include <fftw_threads.h>
#    include <fftw.h>
#  else
#    include <fftw.h>
#  endif
#endif

#endif
