require 'hello_sign'
class WhitelabelController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
    render json: 'Hello API Event Received', status: 200
  end

  def new
  end

  def create
  create_api_app = create_update_api_app(name: params[:name], domain: params[:domain])
  render :updated
  end

private

  def create_update_api_app(opts = {})
 client = HelloSign::Client.new :api_key => params[:api_key]
 client.create_api_app(
    white_labeling_options: {
      "primary_button_color": [params[:primary]],
      "primary_button_text_color": [params[:secondary]]
    },
    custom_logo_file: [params[:upload]]
    )
  end
end