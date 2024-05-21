#!/bin/bash

mkdir -p patch
rm -f temp

versions="514 515 516 X27 602 610 611 620"

for version in ${versions}; do
  folder=MCNP${version}
  if [ ${version} == "X27" ]; then patch=mcnpx27.patch
  else patch=mcnp${version}.patch
  fi
  mv ${folder}/Source      ${folder}/Source_new
  mv ${folder}/Source_orig ${folder}/Source
  diff -rN "--unified=0" ${folder}/Source ${folder}/Source_new > temp
  mv ${folder}/Source      ${folder}/Source_orig
  mv ${folder}/Source_new  ${folder}/Source
  sed -e "s/.inc\t.*/.inc/" \
      -e "s/.c\t.*/.c/"     \
      -e "s/.h\t.*/.h/"     \
      -e "s/.F\t.*/.F/"     \
      -e "s/.F90\t.*/.F90/" \
      temp > patch/${patch}
  rm -f temp
done
