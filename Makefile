PY?=python3
VENVDIR?=$(CURDIR)/.venv
PELICAN?=$(VENVDIR)/bin/pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py
CVDIR=$(BASEDIR)/cv

GCS_BUCKET=gs://jespernyerup.dk


DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

RELATIVE ?= 0
ifeq ($(RELATIVE), 1)
	PELICANOPTS += --relative-urls
endif

help:
	@echo 'Makefile for a pelican Web site                                           '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make venv                           create .venv and install Pelican   '
	@echo '   make html                           (re)generate the web site          '
	@echo '   make clean                          remove the generated files         '
	@echo '   make regenerate                     regenerate files upon modification '
	@echo '   make publish                        generate using production settings '
	@echo '   make serve [PORT=8000]              serve site at http://localhost:8000'
	@echo '   make serve-global [SERVER=0.0.0.0]  serve (as root) to $(SERVER):80    '
	@echo '   make devserver [PORT=8000]          serve and regenerate together      '
	@echo '   make cv                             rebuild static/files/cv.pdf from cv/  '
	@echo '   make upload                         publish the web site to $(GCS_BUCKET)'
	@echo '                                                                          '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html   '
	@echo 'Set the RELATIVE variable to 1 to enable relative urls                    '
	@echo '                                                                          '

# Pelican and its dependencies live in a virtualenv in the working tree rather
# than being installed system-wide. The other targets depend on this, so a
# fresh clone only needs `make html`.
venv: $(VENVDIR)/bin/pelican

$(VENVDIR)/bin/pelican: requirements.txt
	$(PY) -m venv $(VENVDIR)
	$(VENVDIR)/bin/pip install --quiet --upgrade pip
	$(VENVDIR)/bin/pip install --quiet -r requirements.txt

html: venv
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

distclean: clean
	[ ! -d $(VENVDIR) ] || rm -rf $(VENVDIR)

regenerate: venv
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

serve: venv
ifdef PORT
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT)
else
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif

serve-global:
ifdef SERVER
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT) -b $(SERVER)
else
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT) -b 0.0.0.0
endif


devserver: venv
ifdef PORT
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT)
else
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif

publish: venv
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

# Needs a LaTeX distribution. BasicTeX is enough and is a great deal smaller
# than MacTeX:
#
#   brew install --cask basictex
#   sudo tlmgr update --self
#   sudo tlmgr install moderncv changepage enumitem latexmk fontawesome6 \
#       marvosym lastpage charter multirow arydshln
#
cv:
	cd $(CVDIR) && latexmk -pdf -silent cv.tex
	cp $(CVDIR)/cv.pdf $(BASEDIR)/static/files/cv.pdf

# The sync deletes whatever is in the bucket but not in $(OUTPUTDIR). /bsr/ is
# maintained outside this repository, so it has to be held back explicitly or
# it goes on every publish.
upload: publish
	gcloud storage rsync --recursive --delete-unmatched-destination-objects \
		--exclude='^bsr/' \
		$(OUTPUTDIR)/ $(GCS_BUCKET)/


.PHONY: venv html help clean distclean regenerate serve serve-global devserver stopserver publish cv upload
