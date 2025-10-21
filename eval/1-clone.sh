#!/bin/bash

#BASE_URL="git@gitlab.rnl.tecnico.ulisboa.pt:leic-a-po25/prj"
#REPO_RANGE=( 000 {001..020} 022 023 {026..071} {073..126} 128 129 {131..133} {196..199} )
#REPO_RANGE=( 000 {001..004} {006..020} 022 023 {025..071} {073..107} {109..126} 128 129 {131..133} )
REPO_NAME=$2

#clone_repos() {
#  mkdir -p checked-out
#  for i in "${REPO_RANGE[@]}"; do
#    (cd checked-out && git clone "$BASE_URL/$i.git")
#  done
#  #wait
#}

# copia direta
clone_repos() {
  mkdir -p checked-out
  cp -a ../../$REPO_NAME ./checked-out/$REPO_NAME
}

checkout_reference_at_date() {
  local dir=$1 date=$2
  (cd "checked-out-ref/$dir"; git -c advice.detachedHead=false checkout $(git rev-list -1 --date=iso --before="$date" master))
}

DELIVERY=$1
if [[ ! $DELIVERY =~ ^(e0|ei|ef)$ ]]; then
    echo "Error: DELIVERY must be set to one of 'e0', 'ei', or 'ef'" >&2
    echo "Usage: 1-clone.sh DELIVERY " >&2
    exit 1
fi

rm -rf checked-out checked-out-ref

clone_repos
cp -a checked-out checked-out-ref


#i=$REPO_NAME
#  case $DELIVERY in
#    e0) checkout_reference_at_date $i "2025-09-06T22:09:00+00:00" ;;
#    ei) checkout_reference_at_date $i "2025-09-24T13:30:00+00:00" ;;
#    ef) checkout_reference_at_date $i "2025-10-08T13:00:00+00:00" ;;
#  esac

#-- clear histories
#rm -rf checked-out-ref/???/.git
#rm -rf checked-out/???/.git

