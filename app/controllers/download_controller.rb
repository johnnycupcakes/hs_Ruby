require 'hello_sign'
class DownloadController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
    data = JSON.parse(params["json"], symbolize_names: true)
    sig_request = data[:signature_request][:signature_request_id]
    decline = data[:signature_request][:signatures][0][:decline_reason]
    who = data[:signature_request][:signatures][0][:signer_email_address]
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
    p "The signature request has been declined. #{who} declined because: #{decline}"
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
  downloadfiles = create_downloadfiles(name: params[:name], email: params[:email])
  @sign_url = get_sign_url(downloadfiles)
  render :download_signature
  end

private

  def downloadfiles (opts = {})
  client = HelloSign::Client.new :api_key => params[:api_key]
  client.downloadfiles(
  file_bin = client.signature_request_files :signature_request_id => params[signature_request_id], :file_type => 'zip'
  open("files.zip", "wb") do |file|
    file.write(file_bin)
  end


end