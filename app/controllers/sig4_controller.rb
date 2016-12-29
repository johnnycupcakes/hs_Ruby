require 'hello_sign'
class Sig4Controller < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
    render json: 'Hello API Event Received', status: 200
  end

  def new
  end

  def create
  signature_request = create_signature_request(name: params[:name], email: params[:email])
  render :sent
  end

private

  def create_signature_request(opts = {})
 client = HelloSign::Client.new :api_key => params[:api_key]
 client.send_signature_request(
    test_mode: 1,
    files: [params[:upload]],
    subject: params[:subject],
    message: params[:message],
    signers: [
        {
            :email_address => params[:signer_email],
            :name => params[:signer_name]
        }
    ]
    )
  end
end