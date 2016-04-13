#!/usr/bin/env bash
#
# todo.sh:jeff
#
#

function find_dodo()
{
  DPATH='.'
  if [[ -n $1 ]]; then
    DPATH=$1
  fi

  # STORED_IFS=$IFS
  # IFS=$(printf "%q\n")
  LIST=$(find ${DPATH} -name *.dodo -type f)
  # echo "${LIST}"

  for file in ${LIST}; do
    FILE_TYPE=$(head -n1 $file | fgrep -i .dodo)

    echo "DODO: ${file}"
    echo "FILE_TYPE: ${FILE_TYPE}"

    PROJECT_NAME=$(basename -s .dodo ${file})

    echo -ne "\tPROJ: ${PROJECT_NAME}\n"

    FILE_SIZE=$(stat -f %z ${HOME}/.dodos)
    if [[ $? -eq 0 ]]; then
      echo "fs: $FILE_SIZE"

      # $FILE_SIZE -eq ""
      if [[ $FILE_SIZE -gt 0 ]]; then
        echo -ne "\n" >> "${HOME}/.dodos"
      fi

      cat $file >> "${HOME}/.dodos"
    fi
  done

  # IFS=$STORED_IFS
}

if [[ -f "${HOME}/.dodos" ]]; then
  rm "${HOME}/.dodos"
fi

touch "${HOME}/.dodos"
echo -ne "My dodos\n" >> "${HOME}/.dodos"

find_dodo
