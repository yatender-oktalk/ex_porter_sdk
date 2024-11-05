defmodule ExPorterSDK.Quote.Impl do
  def get_quote(config, params) do
    Req.post(config.base_url <> "/quote/get",
      json: params,
      headers: [{"x-api-key", config.api_key}]
    )
  end
end
