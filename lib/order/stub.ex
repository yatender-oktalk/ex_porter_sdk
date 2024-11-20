defmodule ExPorterSDK.Order.Stub do
  @moduledoc """
  Stub implementation of Order operations for testing.
  """

  @behaviour ExPorterSDK.Behaviours.Order

  @impl true
  @impl true
  def create(_params) do
    {:ok,
     %{
       "order_id" => "CRN1732081876717",
       "status" => "created",
       "estimated_price" => %{
         "currency" => "INR",
         "minor_amount" => 68
       },
       "pickup_eta" => 1_651_762_986
     }}
  end

  @impl true
  def track(_order_id) do
    {:ok,
     %{
       "order_id" => "CRN1732081876717",
       "status" => "in_progress",
       "fare_details" => %{
         "actual_fare_details" => nil,
         "estimated_fare_details" => %{"currency" => "INR", "minor_amount" => 68}
       },
       "order_timings" => %{
         "order_accepted_time" => 1_651_759_436,
         "order_ended_time" => nil,
         "order_started_time" => nil,
         "pickup_time" => 1_651_762_986
       },
       "partner_info" => %{
         "name" => "Test Driver",
         "phone_number" => "+919876543210",
         "vehicle_number" => "KA01AB1234"
       }
     }}
  end

  @impl true
  def cancel(_order_id) do
    {:ok, %{"code" => 200, "message" => "order got cancelled successfully!!"}}
  end
end
