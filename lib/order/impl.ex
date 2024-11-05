defmodule ExPorterSDK.Order.Impl do
  @moduledoc "Handles order-related operations"

  alias ExPorterSDK.Client.Config

  @spec create(Config.t(), map()) :: {:ok, map()} | {:error, map()}
  def create(config, params) do
    Req.post(config.base_url <> "/order/create",
      json: params,
      headers: [{"x-api-key", config.api_key}]
    )
  end

  @spec track(Config.t(), String.t()) :: {:ok, map()} | {:error, map()}
  def track(config, order_id) do
    Req.post(config.base_url <> "/order/track",
      json: %{order_id: order_id},
      headers: [{"x-api-key", config.api_key}]
    )
  end

  @spec cancel(Config.t(), String.t(), String.t()) :: {:ok, map()} | {:error, map()}
  def cancel(config, order_id, reason) do
    Req.post(config.base_url <> "/order/cancel",
      json: %{order_id: order_id, reason: reason},
      headers: [{"x-api-key", config.api_key}]
    )
  end
end
