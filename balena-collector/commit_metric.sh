#!/bin/sh

set -ex
TEXTFILEDIR=${TEXTFILEDIR:-/textfiles}

fname="${TEXTFILEDIR}/${1}.prom"

tee "${fname}\$$"
mv "${fname}\$$" "${fname}"
