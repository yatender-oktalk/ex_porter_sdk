defmodule ExPorterSDK do
  @moduledoc """
  Porter delivery service SDK for Elixir.

  ## Configuration

  Add to your `config.exs` or appropriate environment config file:

      config :ex_porter_sdk,
        base_url: "https://api.porter.in",  # Required
        api_key: "your-api-key",            # Required
        quote_impl: ExPorterSDK.Quote.Impl, # Optional, defaults to Impl
        order_impl: ExPorterSDK.Order.Impl  # Optional, defaults to Impl

  Or configure at runtime:

      Application.put_env(:ex_porter_sdk, :base_url, "https://api.porter.in")
      Application.put_env(:ex_porter_sdk, :api_key, "your-api-key")

  ## Usage Example

      # Get delivery quote
      {:ok, quote} = ExPorterSDK.Quote.get_quote(%{
        pickup_details: %{
          lat: 12.909728,
          lng: 77.600139
        },
        drop_details: %{
          lat: 12.897957,
          lng: 77.621197
        }
      })

      # Create order
      {:ok, order} = ExPorterSDK.Order.create(%{
        quote_id: quote["quote_id"],
        customer: %{
          name: "Test User",
          mobile: %{
            country_code: "+91",
            number: "9876543210"
          }
        }
      })

      # Track order
      {:ok, tracking} = ExPorterSDK.Order.track(order["order_id"])

      # Cancel order
      {:ok, result} = ExPorterSDK.Order.cancel(order["order_id"], "customer request")

  ## Testing

  For testing, you can use the provided stubs:

      # In config/test.exs
      config :ex_porter_sdk,
        quote_impl: ExPorterSDK.Quote.Stub,
        order_impl: ExPorterSDK.Order.Stub

      # Or set temporarily in tests
      Application.put_env(:ex_porter_sdk, :quote_impl, ExPorterSDK.Quote.Stub)
      Application.put_env(:ex_porter_sdk, :order_impl, ExPorterSDK.Order.Stub)
  """

  @doc """
  Returns the configured base URL for the Porter API.
  Raises if not configured.
  """
  def base_url do
    Application.get_env(:ex_porter_sdk, :base_url) ||
      raise """
      Porter SDK base_url not configured. Add to your config:

      config :ex_porter_sdk,
        base_url: "https://api.porter.in"
      """
  end

  @doc """
  Returns the configured API key for the Porter API.
  Raises if not configured.
  """
  def api_key do
    Application.get_env(:ex_porter_sdk, :api_key) ||
      raise """
      Porter SDK api_key not configured. Add to your config:

      config :ex_porter_sdk,
        api_key: "your-api-key"
      """
  end
end
