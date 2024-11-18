defmodule ExPorterSDK.Order do
  @moduledoc """
  Order operations dispatcher based on environment.
  """

  def create(params), do: impl().create(params)
  def track(order_id), do: impl().track(order_id)
  def cancel(order_id, reason), do: impl().cancel(order_id, reason)

  defp impl do
    Application.get_env(:ex_porter_sdk, :order_impl, ExPorterSDK.Order.Impl)
  end
end
