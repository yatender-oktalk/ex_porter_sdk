defmodule ExPorterSDK.Behaviours.Order do
  @callback create(params :: map()) :: {:ok, map()} | {:error, map()}
  @callback track(order_id :: String.t()) :: {:ok, map()} | {:error, map()}
  @callback cancel(order_id :: String.t(), reason :: String.t()) :: {:ok, map()} | {:error, map()}
end
