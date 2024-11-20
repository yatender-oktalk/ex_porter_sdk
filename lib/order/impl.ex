defmodule ExPorterSDK.Order.Impl do
  alias ExPorterSDK.ErrorHandler

  def create(params) do
    config = ExPorterSDK.Config.get()

    Req.post(config.base_url <> "/v1/orders/create",
      json: params,
      headers: [{"x-api-key", config.api_key}]
    )
    |> ErrorHandler.handle_response()
  end

  def track(order_id) do
    config = ExPorterSDK.Config.get()

    Req.get(config.base_url <> "/v1/orders/#{order_id}",
      headers: [{"x-api-key", config.api_key}]
    )
    |> ErrorHandler.handle_response()
  end

  def cancel(order_id) do
    config = ExPorterSDK.Config.get()

    Req.post(config.base_url <> "/v1/orders/#{order_id}/cancel",
      headers: [{"x-api-key", config.api_key}]
    )
    |> ErrorHandler.handle_response()
  end
end
