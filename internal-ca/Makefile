
.PHONY: bundle clean clean-describe confirm newca newca-describe tgz realclean realclean-describe

#
# list of services (for the 'all' target)
#
SERVICES = gateway \
	xuudb \
	registry \
	workflow \
	authserver \
	uftpd \
	unicorex

all: clean $(SERVICES:=.pem)

#
# Base for distinguished names. 
# The common name field 'CN=...' will be appended
#
SUBJECT_BASE = /C=EU/O=UNICORE/OU=Internal PKI

#
# issue a new credential
#
%.pem:
	@SUBJECT='$(SUBJECT_BASE)/CN=$*' ./CA -newreq
	@./CA -sign
	@echo "***"
	@echo "*** Generating credential file certs/$*.key ... "
	@echo "***"
	@cat newkey.pem >> certs/$*.pem
	@cat newcert.pem >> certs/$*.pem
	@cat certs/trusted/internal-unicore-cacert.pem >> certs/$*.pem
	@cp newcert.pem certs/$*.cert
	@rm -f newcert.pem newkey.pem newreq.pem

bundle:
	@echo "Creating certificates bundle ..."
	@tar czf certificates.tgz certs/*

#
# setup CA from scratch
#
newca: newca-describe confirm
	@rm CAfiles/* -rf
	@rm certs/* -rf
	@mkdir -p CAfiles
	@mkdir -p certs/trusted
	@SUBJECT='$(SUBJECT_BASE)/CN=Issuer Certificate' ./CA -newca
	@cp CAfiles/cacert.pem certs/trusted/internal-unicore-cacert.pem

newca-describe:
	@echo "This will create a new CA, including new CA private key and everything."

tgz:
	@echo "Creating internal-ca.tgz ..."
	@tar czf internal-ca.tgz CA Makefile openssl.cnf README

clean-describe:
	@echo "This will delete all issued certificates."

clean: clean-describe confirm
	@echo "Removing issued certificates..."
	@rm -f certs/*.key certs/*.pem

realclean-describe:
	@echo "This will delete ALL CA files and issued certificates."

realclean: realclean-describe confirm
	@echo "Removing CA files and all issued certificates..."
	@rm -rf CAfiles
	@rm -rf certs
	@rm -rf *.pem *.key *.tgz
	@find -name "*~" -delete
	@rm -f internal-ca.tgz
	@rm -f certificates.tgz

confirm:
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
