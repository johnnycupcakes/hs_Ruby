require 'hello_sign'
class RequestingController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
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
