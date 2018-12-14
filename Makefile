# Absolute path to the Inkscape executable
INKSCAPE := /Applications/Inkscape.app/Contents/Resources/bin/inkscape

# Change this to the name of the svg you're processing.
SVG := foo.svg

# PDF export area; one of "page" or "drawing"
PDF_EXPORT_AREA := page

# PNG export area; one of "page" or "drawing"
PNG_EXPORT_AREA := drawing

PNG_BACKGROUND_COLOR := white
PNG_WIDTH := 1200

## Everything from here on should Just Work.

FN := ${basename ${SVG}}
PDF_DIR := pdf
PNG_DIR := png
PDF := ${PDF_DIR}/${FN}.pdf
PNG := ${PNG_DIR}/${FN}.png

# All paths need to be absolute when using Inkscape from the command line. 
# This will quote spaces in the path...
BASEDIR := $(shell echo ${PWD} | sed 's/ /\\ /g')

.PHONY: pdf png clean clean-pdf clean-png

all: pdf png

pdf:	${PDF}

png:	${PNG}

clean: clean-pdf clean-png

clean-pdf:
	rm -f ${PDF}
	rmdir ${PDF_DIR}

clean-png:
	rm -f ${PNG}
	rmdir ${PNG_DIR}

${PDF_DIR}/%.pdf:	%.svg
	mkdir -p ${PDF_DIR}
	${INKSCAPE} --export-area-${PDF_EXPORT_AREA} --export-pdf=${BASEDIR}/$@ ${BASEDIR}/$<

${PNG_DIR}/%.png:	%.svg
	mkdir -p ${PNG_DIR}
	${INKSCAPE} --export-area-${PNG_EXPORT_AREA} --export-png=${BASEDIR}/$@ --export-background=${PNG_BACKGROUND_COLOR} --export-width=${PNG_WIDTH} ${BASEDIR}/$<
