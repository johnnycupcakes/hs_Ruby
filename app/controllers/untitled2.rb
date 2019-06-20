
require 'hello_sign'

client = HelloSign::Client.new :api_key => 'API KEY'
client.send_signature_request_with_template(
    :test_mode => 1,
    :template_id => '5d0c5c6cb9cc142c65b7b1925bb428f2',
    :subject => 'Purchase Order',
    :message => 'Glad we could come to an agreement.',
    :signers => [
        {
            :email_address => 'winson.auyeung@hellosign.com',
            :name => 'George',
            :role => 'Bill'
        }
    ]
)


require 'hello_sign'

client = HelloSign::Client.new :api_key => 'API KEY'
client.send_signature_request_with_template(
    :test_mode => 1,
    :template_id => '912c4b593ca0e1d8806d1768bd9034b2386dbad5',
    :subject => 'Purchase Order',
    :message => 'Glad we could come to an agreement.',
    :signers => [
        {
            :email_address => 'nicholas.boutte@hellosign.com',
            :name => 'George',
            :role => 'client'
        }
    ]
)
