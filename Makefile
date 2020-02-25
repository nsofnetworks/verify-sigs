.PHONY: unittest
all: ci_build pylint unittest

ci_build:
	@docker build -t verifysigs-ci -f Dockerfile.ci .

pylint: ci_build
	@docker run -v $(PWD):/code verifysigs-ci pylint --rcfile=conf/pylint.cfg *.py asn1

unittest: ci_build
	@docker run -v $(PWD):/code verifysigs-ci ./fingerprinter_test.py
