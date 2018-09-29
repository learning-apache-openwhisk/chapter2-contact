# Sample Contact form

To deploy, first get 

- An Access to OpenWhisk, with a configured `wsk` command line with tokens.
- Cloudant User and Password
- Mailgun Api key and Sandbox domain
- Pick an email recipient of the contact form

Then type `./config.sh <user> <pass> <apikey> <sandbox> <recipient>`

You can now deploy with `make deploy` and undeploy with `make clean`

Use `make url` to get the URL to access the contact form.
