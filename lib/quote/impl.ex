defmodule ExPorterSDK.Quote.Impl do
  def get_quote(config, params) do
    Req.get(config.base_url <> "/v1/get_quote",
      json: params,
      headers: [{"x-api-key", config.api_key}]
    )
  end
end
