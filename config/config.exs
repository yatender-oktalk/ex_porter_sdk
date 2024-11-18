import Config

config :ex_porter_sdk,
  base_url: "https://pfe-apigw-uat.porter.in",
  api_key: System.get_env("PORTER_API_KEY")

import_config "#{config_env()}.exs"
