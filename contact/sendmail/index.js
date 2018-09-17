var mailgun = require("mailgun.js")
function main(args) {
  var mg = mailgun.client({
      username: 'api', 
      key: args.apikey
  })
  return mg.messages.create(
	  args.sandbox, {
    from: args.recipient,
    to: [args.recipient],
    subject: "[Contact Form]",
    html: args.body
  }).then(function(msg) {
     console.log(msg);
     return args;
  }).catch(function(err) {
     console.log(err);
     return args;
  })
}
exports.main = main
