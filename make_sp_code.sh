#!/bin/bash

source dimensions.in
echo "#ifndef _SP_LINALG_H"
echo "#define _SP_LINALG_H"

echo "#include <math.h>"
echo "#include \"cvc_complex.h\""
echo "#include \"cvc_linalg.h\""
echo ""
echo "// spinor dimension: $N_SPINOR_DIM"
echo "// color dimension: $N_COLOR_DIM"
echo ""


# ----------------------------------------------------------------------------------------------------------------

echo "#define _sp_eq_zero(_r) {\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] = 0.;\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] = 0.;\\"
  done
done
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------

echo "#define _sp_eq_sp(_r, _s) {\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] = (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))];\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] = (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))];\\"
  done
done
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------

echo "#define _sp_eq_sp_transposed(_r, _s) {\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] = (_s)[$(printf "%2d" $alpha)][$(printf "%2d" $((2*$beta)))];\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] = (_s)[$(printf "%2d" $alpha)][$(printf "%2d" $((2*$beta+1)))];\\"
  done
done
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------

echo "#define _sp_pl_eq_sp(_r, _s) {\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] += (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))];\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] += (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))];\\"
  done
done
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------

echo "#define _sp_mi_eq_sp(_r, _s) {\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] -= (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))];\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] -= (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))];\\"
  done
done
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------

echo "#define _sp_eq_sp_ti_re(_r, _s, _c) {\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] = (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] * (_c);\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] = (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] * (_c);\\"
  done
done
echo -e "}\n\n"


# ----------------------------------------------------------------------------------------------------------------

echo "#define _sp_eq_sp_ti_im(_r, _s, _c) {\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] = -(_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] * (_c);\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] = +(_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] * (_c);\\"
  done
done
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------

echo "#define _sp_eq_sp_ti_co(_r, _s, _c) {\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] = +(_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] * (_c).re - (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] * (_c).im;\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] = +(_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] * (_c).im + (_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] * (_c).re;\\"
  done
done
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------


echo "#define _sp_eq_gamma_ti_sp(_r, _mu, _s) {\\"
echo "int __perm[$N_SPINOR_DIM], __isimag;\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  echo "__perm[$(printf "%2d" $beta)] = gamma_permutation[(_mu)][$(printf "%2d" $((2*$N_COLOR_DIM*$beta)))]/$((2*N_COLOR_DIM));\\"
done
echo "__isimag = gamma_permutation[(_mu)][0]%2;\\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  for((alpha=0;alpha<$N_SPINOR_DIM;alpha++)); do
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha)))] = (_s)[$(printf "%2d" $beta)][2*__perm[$(printf "%2d" $alpha)]  +__isimag] * gamma_sign[(_mu)][$(printf "%2d" $((2*$N_COLOR_DIM*$alpha)))];\\"
    echo "(_r)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$alpha+1)))] = (_s)[$(printf "%2d" $beta)][2*__perm[$(printf "%2d" $alpha)]+1-__isimag] * gamma_sign[(_mu)][$(printf "%2d" $((2*$N_COLOR_DIM*$alpha+1)))];\\"
  done
done
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------


echo "#define _co_eq_tr_sp(_c, _s) {\\"
echo "(_c)->re = \\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  echo " +(_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$beta)))]\\"
done
echo ";\\"
echo "(_c)->im = \\"
for((beta=0;beta<$N_SPINOR_DIM;beta++)); do
  echo " +(_s)[$(printf "%2d" $beta)][$(printf "%2d" $((2*$beta+1)))]\\"
done
echo ";\\"
echo -e "}\n\n"

# ----------------------------------------------------------------------------------------------------------------

echo "#endif"
exit 0


