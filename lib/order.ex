defmodule ExPorterSDK.Order do
  @moduledoc "Handles order-related operations"

  alias ExPorterSDK.Client.Config
  alias ExPorterSDK.Order.Impl

  @spec create(Config.t(), map()) :: {:ok, map()} | {:error, map()}
  def create(config, params) do
    Impl.create(config, params)
  end

  @spec track(Config.t(), String.t()) :: {:ok, map()} | {:error, map()}
  def track(config, order_id) do
    Impl.track(config, order_id)
  end

  @spec cancel(Config.t(), String.t(), String.t()) :: {:ok, map()} | {:error, map()}
  def cancel(config, order_id, reason) do
    Impl.cancel(config, order_id, reason)
  end
end
