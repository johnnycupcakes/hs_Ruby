require 'hello_sign'
class SignaturesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
    data = JSON.parse(params["json"], symbolize_names: true)
    sig_request = data[:signature_request][:signature_request_id]
    event = data[:event][:event_type]
  if (event == "signature_request_downloadable")
    p "***********"
    p "The signature request is ready to download"
  elsif (event == "signature_request_sent")
    p "***********"
    p "The signature request has been sent"
  elsif (event == "signature_request_viewed")
    p "***********"
    p "The signature request has been viewed"
  elsif (event == "signature_request_signed")
    p "***********"
    p "The signature request has been signed, please wait to download."
  elsif (event == "signature_request_all_signed")
    p "***********"
    p "The signature request has been completed and is ready to download. The signature request ID is #{sig_request}"
  elsif (event == "signature_request_declined")
    p "***********"
    p "The signature request has been declined"
  elsif (event == "signature_request_reassigned")
    p "***********"
    p "The signature request has been reassigned"
  else
    p "***********"
    p "Something went horribly wrong, please check your API Dashboard."
  end
  
    render json: 'Hello API Event Received', status: 200
end
  def new
  end

  def create
  embedded_signature_request_with_template = create_embedded_signature_request_with_template(name: params[:name], email: params[:email])
  @sign_url = get_sign_url(embedded_signature_request_with_template)
  @client_id = params[:client_id]
  render :embedded_signature
  end

private

  def create_embedded_signature_request_with_template(opts = {})
  client = HelloSign::Client.new :api_key => params[:api_key]
client.create_embedded_signature_request_with_template(
      test_mode: 1, #Set this to 1 for 'true'. 'false' is 0
      client_id: params[:client_id],
      subject: params[:subject],
      message: '',
      template_id: params[:template_id],
      allow_decline: params[:decline],
      signers: [
        {
            :email_address => 'nicholas.boutte+1@hellosign.com',
            :name => 'Signer',
            :role => params[:signer_role]
        }
      ]
    )
  end

def get_sign_url(embedded_request)
  sign_id = get_first_signature_id(embedded_request)
  client = HelloSign::Client.new :api_key => params[:api_key]
  client.get_embedded_sign_url(signature_id: sign_id).sign_url
end

def get_first_signature_id(embedded_request)
  embedded_request.signatures[0].signature_id
end
end