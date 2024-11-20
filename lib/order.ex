defmodule ExPorterSDK.Order do
  @moduledoc """
  Order operations dispatcher based on environment.

  This module provides functions to create, track, and cancel orders
  in the Porter API. It dynamically dispatches to the appropriate
  implementation based on the application configuration.

  ## Functions

  - `create/1`: Create a new order.
  - `track/1`: Retrieve the status of an existing order.
  - `cancel/2`: Cancel an existing order.

  ## Example Usage

      iex> ExPorterSDK.Order.create(%{pickup_details: ..., drop_details: ..., delivery_instructions: ...})
      {:ok, order_response}

      iex> ExPorterSDK.Order.track("order_id")
      {:ok, order_status}

      iex> ExPorterSDK.Order.cancel("order_id", "Customer request")
      {:ok, cancellation_response}
  """

  @behaviour ExPorterSDK.Behaviours.Order

  @doc """
  Create an order.

  This function takes a map of parameters required to create an order.
  It delegates the call to the appropriate implementation.

  ## Parameters

  - `params`: A map containing the necessary details for the order
    including `pickup_details`, `drop_details`, and `delivery_instructions`.

  ## Returns

  - `{:ok, response}`: On success, returns the response from the API.
  - `{:error, reason}`: On failure, returns an error reason.

  ### Example

      iex> ExPorterSDK.Order.create(%{pickup_details: ..., drop_details: ..., delivery_instructions: ...})
      {:ok, %{order_id: "12345", status: "created"}}
  """
  @impl ExPorterSDK.Behaviours.Order
  def create(params), do: impl().create(params)

  @doc """
  Track an order.

  This function retrieves the current status of a specific order.

  ## Parameters

  - `order_id`: The unique identifier of the order to be tracked.

  ## Returns

  - `{:ok, order_status}`: On success, returns the current status of the order.
  - `{:error, reason}`: On failure, returns an error reason.

  ### Example

      iex> ExPorterSDK.Order.track("order_id")
      {:ok, %{status: "in_transit", estimated_delivery: "2023-10-20T10:00:00Z"}}
  """
  @impl ExPorterSDK.Behaviours.Order
  def track(order_id), do: impl().track(order_id)

  @doc """
  Cancel an order.

  This function cancels an existing order based on its order ID.

  ## Parameters

  - `order_id`: The unique identifier of the order to be canceled.
  - `reason`: A string specifying the reason for cancellation.

  ## Returns

  - `{:ok, cancellation_response}`: On success, returns the cancellation response.
  - `{:error, reason}`: On failure, returns an error reason.

  ### Example

      iex> ExPorterSDK.Order.cancel("order_id")
      {:ok, %{message: "Order canceled successfully"}}
  """
  @impl ExPorterSDK.Behaviours.Order
  def cancel(order_id), do: impl().cancel(order_id)

  defp impl do
    Application.get_env(:ex_porter_sdk, :order_impl, ExPorterSDK.Order.Impl)
  end
end
