require 'hello_sign'
class RequestingController < ApplicationController
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
    @claim_url = create_embedded_unclaimed_draft
    @client_id = params[:client_id]
    render :embedded_request
  end

private

  def create_embedded_unclaimed_draft
    client = HelloSign::Client.new :api_key => params[:api_key]
    response = client.create_embedded_unclaimed_draft(
      test_mode: 1,
      client_id: params[:client_id],
      type: 'request_signature',
      subject: params[:subject],
      requester_email_address: params[:requester_email_address],
      files: [params[:upload]]
    )
    response.claim_url
  end
end
