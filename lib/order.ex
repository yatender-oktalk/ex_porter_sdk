defmodule ExPorterSDK.Order do
  @moduledoc "Handles order-related operations"

  alias ExPorterSDK.Client.Config

  @spec create(Config.t(), map()) :: {:ok, map()} | {:error, map()}
  def create(config, params) do
    module().create(config, params)
  end

  @spec track(Config.t(), String.t()) :: {:ok, map()} | {:error, map()}
  def track(config, order_id) do
    module().track(config, order_id)
  end

  @spec cancel(Config.t(), String.t(), String.t()) :: {:ok, map()} | {:error, map()}
  def cancel(config, order_id, reason) do
    module().cancel(config, order_id, reason)
  end

  defp module do
    Application.get_env(:ex_porter_sdk, :order_impl, ExPorterSDK.Order.Impl)
  end
end
