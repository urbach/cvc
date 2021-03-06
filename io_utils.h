/* $Id: io_utils.h,v 1.2 2007/11/22 15:57:38 urbach Exp $ */

#ifndef _IO_UTILS_H
#define _IO_UTILS_H

#ifndef isnan
# define isnan(x)						 \
  (sizeof (x) == sizeof (long double) ? isnan_ld (x)		 \
   : sizeof (x) == sizeof (double) ? isnan_d (x)		 \
   : isnan_f (x))

#endif

typedef void* (*copy_function)(void* out_ptr, void* in_ptr, int nmemb);

int isnan_f  (float       x);
int isnan_d  (double      x);
int isnan_ld (long double x);

void byte_swap(void *ptr, int nmemb);
void byte_swap_double(void *ptr, int nmemb);
inline void* byte_swap_assign(void * out_ptr, void * in_ptr, int nmemb);
inline void* byte_swap_assign_singleprec(void * out_ptr, void * in_ptr, int nmemb);
inline void* byte_swap_assign_single2double(void * out_ptr, void * in_ptr, int nmemb);
inline void* single2double(void * out_ptr, void * in_ptr, int nmemb);
inline void* byte_swap_assign_double2single(void * out_ptr, void * in_ptr, int nmemb);
inline void* double2single(void * out_ptr, void * in_ptr, int nmemb);
int big_endian();
int write_ildg_format_xml(char *filename, LimeWriter * limewriter, const int precision);
void single2double_cm(double * const R, float * const S);
void double2single_cm(float * const S, double * const R);
void zero_spinor(double * const R);
void byte_swap64(void * ptr, int nmemb);
void byte_swap64_v2(double *ptr, unsigned int nmemb);

#endif
