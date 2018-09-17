var openwhisk = require('openwhisk')

function save(doc)  {
  var ow = openwhisk()
  return ow.actions.invoke({
    "name": "/_/contactdb/write",
    "params": { 
       "dbname": "contact", 
       "doc": doc 
    }
  })
}

function main(args) {
  message = []
  errors = []
  // validate the data
  // TODO: <Form Validation>
  /// validate the name
  if(args.name) {
    message.push("name: "+args.name)
   } else {
    errors.push("No name provided")
   }
  /// validate email
  var re = /\S+@\S+\.\S+/;
  if(args.email && re.test(args.email)) {
     message.push("email: "+args.email)
  } else { 
    errors.push("Email missing or incorrect.")
  }
  /// validate the phone
  if(args.phone && args.phone.toString().match(/\d/g).length >= 10) {
    message.push("phone: "+args.phone)
  } else {
    errors.push("Phone number missing or incorrect.")
  }
  /// add the message text, optional
  if(args.message) {
    message.push("message:\n"+args.message)
  }
  // returning the result 
  // TODO: <Returning the Result>
  /// complete the processing
  var data = "<pre>"+message.join("\n")+"</pre>"
  var errs = "<ul><li>"+errors.join("</li><li>")+"</li></ul>"
  if(errors.length) {
    return {
      body: "<h1>Errors!</h1>"+ 
        data + errs + 
        '<br><a href="javascript:window.history.back()">Back</a>'
    }
  } else {
    // storing in the database
    // TODO: <Store the message in the database>
    save({
        "name": args.name,
        "email": args.email,
        "phone": args.phone,
        "message": args.message
    })
    return {
       body: "<h1>Thank you!</h1>"+ data
    }
  }
}

exports.main = main
