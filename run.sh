#!/bin/bash

[[ $# -ne 1 ]] && echo "Por favor insere o nome da pasta onde esta o projeto (antes desta), tipo:
./run.sh 001" && exit

if ! command -v zsh &> /dev/null; then
  echo "Por favor instala o zsh (no ubuntu: 'sudo apt install zsh')" && exit
fi



# DELIVERY is one of 'e0', 'ei', or 'ef'
DELIVERY=ef
TIMESTAMP=$(date +"%Y%m%d%H%M")
SINGULAR=$1
EVAL_FOLDER=eval

cd $EVAL_FOLDER

chmod +x ./*.sh ./*.jar

./0-begin.sh "$DELIVERY" "$TIMESTAMP"
./1-clone.sh "$DELIVERY" "$SINGULAR"
./2-clean.sh checked-out-ref 2>/dev/null 1>/dev/null
./2-clean.sh checked-out     2>/dev/null 1>/dev/null
./3-prepare.sh               2>/dev/null 1>/dev/null
./4-test.sh "$DELIVERY" "$SINGULAR"
./5-summarize.sh "$DELIVERY" "$SINGULAR"
./6-end.sh "$TIMESTAMP"

cd ..


echo 'beautify lol'
OUTPUT_HTML="$SINGULAR.log.html"
OUTPUT_HTML_ORIGINAL="./$EVAL_FOLDER/logs/$DELIVERY/$OUTPUT_HTML"
cp "$OUTPUT_HTML_ORIGINAL" "./$OUTPUT_HTML"
sed -i 's|$|<p></p>|g' "./$OUTPUT_HTML"



# chatgpt pra abrir o html

echo "Attempting to open $OUTPUT_HTML in your default browser..."
# xdg-open is the standard way on most Linux desktops
if command -v xdg-open &> /dev/null; then
  xdg-open "./$OUTPUT_HTML" &> /dev/null
# 'open' is used on macOS
elif command -v open &> /dev/null; then
  open "./$OUTPUT_HTML" &> /dev/null
else
  echo "Could not find xdg-open or open."
  echo "Please open the file manually in your browser: $OUTPUT_HTML"
fi
