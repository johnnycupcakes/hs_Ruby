require 'hello_sign'
class TemplateController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
    render json: 'Hello API Event Received', status: 200
  end

  def new
  end

  def create
    @edit_url = create_embedded_template_draft
    @client_id = params[:client_id]
    render :embedded_template
  end

private

  def create_embedded_template_draft
  client = HelloSign::Client.new :api_key => params[:api_key]
	response = client.create_embedded_template_draft(
    test_mode: 1,
    client_id: params[:client_id],
    files: ['/Users/nicboutte/downloads/spongebob-01.jpg'],
    title: params[:title],
    subject: params[:subject],
    message: params[:message],
    signer_roles: [
        {
            :name => params[:signer_role],
            :order => params[:signer_order]
        },
        {
            :name => params[:signer_role2],
            :order => params[:signer_order2]
        },
        {
            :name => params[:signer_role3],
            :order => params[:signer_order3]
        },
        {
            :name => params[:signer_role4],
            :order => params[:signer_order4]
        },
        {
            :name => params[:signer_role5],
            :order => params[:signer_order5]
        },
    ],
  )
  response.edit_url
  end
end
