require 'hello_sign'
class Sig2Controller < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
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