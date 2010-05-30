#!/usr/bin/env ruby

require 'lib/twiliolib.rb'

# Twilio REST API version
API_VERSION = '2008-08-01'

# Twilio AccountSid and AuthToken
ACCOUNT_SID = 'ACd68795defff7cfda994cfd09d6895fed'
ACCOUNT_TOKEN = 'c36f140bd45b863419a443c3326e0f76'

# Outgoing Caller ID previously validated with Twilio
CALLER_ID = '4155992671';

# Create a Twilio REST account object using your Twilio account ID and token
ACCOUNT = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

##Send a new outgoinging SMS by POST'ing to the SMS resource, person.number is given from the Foursquare API pull

#people.each do |person|

Response = ACCOUNT.request(\
    "/2008-08-01/Accounts/ACd68795defff7cfda994cfd09d6895fed/SMS/Messages", \
    "POST", { \
      "To" =>"5095526211", \
      "From" =>"415-599-2671", \
      "Body" =>"George sent you a new seed with SeedBust."})
print Response.body
print Response.code