
require 'hello_sign'

client = HelloSign::Client.new :api_key => 'eb3a4f0e817821ffa775df03b83dbb8cc892257ac74cb97aa32f94a9a123854c'
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

client = HelloSign::Client.new :api_key => 'ecac840e03857279f30516eb91d29ed8ebbeefb44f894847d5d10385795381dd'
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