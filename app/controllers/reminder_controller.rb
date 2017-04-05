require 'hello_sign'
class ReminderController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
    render json: 'Hello API Event Received', status: 200
  end

  def new
  end

  def create
  remind_signature_request = create_remind_signature_request(name: params[:name], email: params[:email])
  render :sent
  end

private

  def create_remind_signature_request(opts = {})
 client = HelloSign::Client.new :api_key => params[:api_key]
 client.remind_signature_request :signature_request_id => params[:sig_request_id], :email_address => params[:signer_email]
  end
end