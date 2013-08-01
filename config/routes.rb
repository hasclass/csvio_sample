CsvioSample::Application.routes.draw do
  root :to => "data#home"

  get "data/send_inline" => "data#send_inline"
  get "data/send_file" => "data#send_file"
  get "data/send_url" => "data#send_url"
  get "data/send_httpauth_url" => "data#send_httpauth_url"
  get "data/httpauth_data" => "data#httpauth_data"

end
