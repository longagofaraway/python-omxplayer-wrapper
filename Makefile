PYTHON3:=python3
VERSION:=$(shell $(PYTHON3) setup.py --version)

SRC:=$(shell find omxplayer -iname '*.py')
SDIST:=dist/omxplayer-wrapper-$(VERSION).tar.gz
WHEEL_DIST=dist/omxplayer_wrapper-$(VERSION)-py2.py3-none-any.whl 

.PHONY: all
all: test dist

$(SDIST): setup.py setup.cfg $(SRC)
	$(PYTHON3) setup.py sdist

$(WHEEL_DIST): setup.py setup.cfg $(SRC)
	$(PYTHON3) setup.py bdist_wheel

.PHONY: dist
dist: $(SDIST) $(WHEEL_DIST)

.PHONY: upload-pypi
upload-pypi: dist
	twine upload $(SDIST) $(WHEEL_DIST)

.PHONY: check
check: test

.PHONY: test
test:
	tox

.PHONY: doc
doc:
	$(MAKE) -C docs html
