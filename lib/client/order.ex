defmodule ExPorterSDK.Client.Order do
  @moduledoc """
  HTTP Client for Porter API endpoints using Req.
  """

  require Logger
  alias ExPorterSDK.Client.Config

  @base_headers [
    {"content-type", "application/json"},
    {"x-api-key", Config.api_key()}
  ]

  def request(method, path, body \\ nil) do
    Logger.debug("Making Porter API request",
      method: method,
      path: path,
      body: sanitize_logs(body)
    )

    Req.new(
      base_url: Config.base_url(),
      headers: @base_headers
    )
    |> Req.request(method: method, url: path, json: body)
    |> handle_response(method, path)
  end

  defp handle_response({:ok, %{status: 200, body: body}}, method, path) do
    Logger.info("Porter API request successful",
      method: method,
      path: path,
      status: 200
    )

    {:ok, body}
  end

  defp handle_response({:ok, %{status: status, body: body}}, method, path) do
    Logger.warning("Porter API request failed",
      method: method,
      path: path,
      status: status,
      error: body
    )

    {:error, %{status: status, message: body}}
  end

  defp handle_response({:error, error}, method, path) do
    Logger.error("Porter API request error",
      method: method,
      path: path,
      error: inspect(error)
    )

    {:error, error}
  end

  # Sanitize sensitive data from logs
  defp sanitize_logs(nil), do: nil

  defp sanitize_logs(body) when is_map(body) do
    body
    |> Map.drop(["customer_phone", "api_key"])
    |> Map.new(fn
      {k, v} when is_binary(v) and byte_size(v) > 100 ->
        {k, String.slice(v, 0..100) <> "..."}

      {k, v} ->
        {k, v}
    end)
  end

  @doc """
  Get quote for delivery
  """
  def get_quote(params) do
    Logger.debug("Getting delivery quote", params: sanitize_logs(params))
    request(:post, "/api/v1/quote", params)
  end

  @doc """
  Create a new order
  """
  def create_order(params) do
    Logger.debug("Creating new order", params: sanitize_logs(params))
    request(:post, "/api/v1/order", params)
  end

  @doc """
  Track an order
  """
  def track_order(order_id) do
    Logger.debug("Tracking order", order_id: order_id)
    request(:get, "/api/v1/order/#{order_id}/track")
  end

  @doc """
  Cancel an order
  """
  def cancel_order(order_id, reason) do
    Logger.debug("Cancelling order",
      order_id: order_id,
      reason: reason
    )

    request(:post, "/api/v1/order/#{order_id}/cancel", %{reason: reason})
  end
end
