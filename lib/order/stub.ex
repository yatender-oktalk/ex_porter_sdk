defmodule ExPorterSDK.Order.Stub do
  @moduledoc """
  Stub implementation of Order operations for testing.
  """

  @behaviour ExPorterSDK.Behaviours.Order

  @impl true
  def create(params) do
    {:ok,
     %{
       "order_id" => "test_order_123",
       "status" => "created",
       "params" => params
     }}
  end

  @impl true
  def track(order_id) do
    {:ok,
     %{
       "order_id" => order_id,
       "status" => "in_progress",
       "location" => %{
         "lat" => 12.9716,
         "lng" => 77.5946
       }
     }}
  end

  @impl true
  def cancel(order_id, reason) do
    {:ok,
     %{
       "order_id" => order_id,
       "status" => "cancelled",
       "reason" => reason
     }}
  end
end
