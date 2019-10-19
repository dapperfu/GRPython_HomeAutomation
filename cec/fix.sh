#!/bin/sh
autopep8 --in-place --max-line-length 180 \
	 --aggressive --aggressive --aggressive $1
black --target-version py36 --line-length=180 $1
isort --line-width 180 --multi-line 3 --dont-skip __init__.py $1

