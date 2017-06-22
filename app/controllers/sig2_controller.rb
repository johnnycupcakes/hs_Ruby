require 'hello_sign'
class Sig2Controller < ApplicationController
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
  signature_request_with_template = create_signature_request_with_template(name: params[:name], email: params[:email])
  render :sent
  end

private

  def create_signature_request_with_template(opts = {})
 client = HelloSign::Client.new :api_key => params[:api_key]
client.send_signature_request_with_template(
    test_mode: 1,
    template_id: params[:template_id],
    subject: params[:subject],
    message: params[:message],
    allow_decline: params[:decline],
    signers: [
        {
            :email_address => params[:signer_email],
            :name => params[:signer_name],
            :role => params[:signer_role]
        }
    ]
    )
  end
end