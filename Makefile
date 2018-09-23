include _config.mk

.PHONY: contact form submit bind sendmail submit-sendmail url

deploy: contact bind form submit sendmail submit-sendmail url

undeploy:
	-wsk action delete contact/form
	-wsk action delete contact/submit
	-wsk action delete contact/sendmail
	-wsk action delete contact/submit-sendmail
	-wsk package delete contact 
	-wsk package delete contactdb

contact:
	wsk package update contact

form:
	wsk action update contact/form \
	contact/form.js --web true

bind:
	-wsk package bind /whisk.system/cloudant contactdb \
	-p username $(CLOUDANT_USER) \
	-p password $(CLOUDANT_PASS) \
	-p host $(CLOUDANT_USER).cloudant.com \
	-p dbname contactdb
	-wsk action invoke contactdb/create-database

unbind:
	wsk package delete contactdb

submit:
	wsk action update contact/submit \
	contact/submit.js --web true

sendmail: contact/sendmail.zip
	wsk action update contact/sendmail \
	contact/sendmail.zip \
	--kind nodejs:6 \
	-p apikey $(MAILGUN_APIKEY) \
	-p sandbox $(MAILGUN_SANDBOX) \
	-p recipient $(MAILGUN_RECIPIENT)

contact/sendmail.zip:
	cd contact/sendmail ;\
	npm install ;\
	zip -r ../sendmail.zip index.js node_modules

submit-sendmail:
	-wsk action create contact/submit-sendmail \
  	--sequence contact/submit,contact/sendmail \
  	--web true

url:
	@echo "*** URL ***"
	@wsk action get contact/form --url 2>/dev/null




