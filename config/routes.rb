CsvioSample::Application.routes.draw do
  root :to => "data#home"

  get "data" => "data#index"

  post "data/send_inline" => "data#send_inline"
  post "data/send_file" => "data#send_file"
  post "data/send_url" => "data#send_url"
  post "data/send_httpauth_url" => "data#send_httpauth_url"

  # Callback for csv.io
  get "data/httpauth_data" => "data#httpauth_data"

end
