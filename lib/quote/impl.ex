defmodule ExPorterSDK.Quote.Impl do
  alias ExPorterSDK.ErrorHandler

  def get_quote(params) do
    config = ExPorterSDK.Config.get()

    Req.get(config.base_url <> "/v1/get_quote",
      json: params,
      headers: [{"x-api-key", config.api_key}]
    )
    |> ErrorHandler.handle_response()
  end
end
