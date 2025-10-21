#!/bin/bash

for group in checked-out-ref/[0-9]??; do
  cp -av sane/. $group/.
done

for group in checked-out/[0-9]??; do
  cp -av sane/. $group/.
done

