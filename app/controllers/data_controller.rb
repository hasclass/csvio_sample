class DataController < ApplicationController

  def send_inline
    options = csvio_opts({
      :template => "empty",
      :data => "Hello,World\nHello,Excel"
    })
    response = csvio_export(options)
    redirect_to response['url']
  end

  def send_file
    options = csvio_opts({
      :template => "empty",
      :data => File.new("public/sample_data.csv")
    })
    response = csvio_export(options)
    redirect_to response['url']
  end

  def send_url
    options = csvio_opts({
      :template => "empty",
      :data_url => root_url + "sample_data.csv"
    })
    response = csvio_export(options)
    redirect_to response['url']
  end

  def send_httpauth_url
    e = request.env
    url = "http://username:secret@#{e["REMOTE_HOST"]}:#{e["REMOTE_PORT"]}/data/httpauth_data"
    options = csvio_opts({
      :template => "empty",
      :data_url => url
    })
    response = csvio_export(options)
    redirect_to response['url']
  end

  before_filter :authenticate_csvio!, :only => [:httpauth_data]

  def httpauth_data
    render :text => "hello,world\nfoo,bar"
  end

  protected

  def authenticate_csvio!
    authenticate_or_request_with_http_basic do |username, password|
      username == "user" && password == "secret"
    end
  end

  # Returns hash: {"url" : "http://csv.io/download/..", "uuid" : ..}
  def csvio_export(options)
    response = CsvioClient.post('/export.json', options)
    Rails.logger.info(response.parsed_response)
    response.parsed_response
  end

  def csvio_opts(opts)
    {
      :basic_auth => {:username => CSVIO_API_KEY},
      :body => opts
    }
  end
end