defmodule ExPorterSDK do
  @external_resource "README.md"
  @moduledoc """
  An Elixir SDK for Porter's delivery API, providing a simple and reliable way to integrate
  Porter's logistics services into your Elixir applications.

  ## Features

    * Get delivery quotes based on locations
    * Create and manage delivery orders
    * Track order status in real-time
    * Cancel existing orders
    * Comprehensive test helpers and stubs

  ## Installation

  Add `ex_porter_sdk` to your list of dependencies in `mix.exs`:

      def deps do
        [
          {:ex_porter_sdk, "~> 0.1.0"}
        ]
      end

  ## Configuration

  Configure the SDK in your `config.exs` or appropriate environment config file:

      config :ex_porter_sdk,
        base_url: System.get_env("PORTER_BASE_URL", "https://api.porter.in"),
        api_key: System.get_env("PORTER_API_KEY"),
        quote_impl: ExPorterSDK.Quote.Impl,  # Optional, defaults to Impl
        order_impl: ExPorterSDK.Order.Impl   # Optional, defaults to Impl

  ## Basic Usage

  ### Get Delivery Quote

      params = %{
        pickup_details: %{lat: 12.909728534457143, lng: 77.6001397394293},
        drop_details: %{lat: 12.89795704454522, lng: 77.62119799020186},
        customer: %{
          name: "Test User",
          mobile: %{number: "7678139714", country_code: "+91"}
        }
      }

      case ExPorterSDK.Quote.get_quote(params) do
        {:ok, response} ->
          # Handle successful response
          IO.inspect(response["vehicles"])

        {:error, error} ->
          # Handle error
          IO.inspect(error)
      end

  ### Create Order

      order_params = %{
        request_id: "unique-request-id",
        delivery_instructions: %{
          instructions_list: [
            %{type: "text", description: "handle with care"}
          ]
        },
        pickup_details: %{
          address: %{
            apartment_address: "27",
            street_address1: "Main Street",
            city: "Bengaluru",
            state: "Karnataka",
            pincode: "560029",
            country: "India",
            lat: 12.939391726766775,
            lng: 77.62629462844717,
            contact_details: %{
              name: "Test User",
              phone_number: "+911234567890"
            }
          }
        },
        drop_details: %{
          # Similar structure as pickup_details
        }
      }

      {:ok, order} = ExPorterSDK.Order.create(order_params)

  ### Track Order

      {:ok, status} = ExPorterSDK.Order.track("order_id")

  ### Cancel Order

      {:ok, response} = ExPorterSDK.Order.cancel("order_id")

  ## Testing

  The SDK provides stub implementations for testing. Configure them in your `config/test.exs`:

      config :ex_porter_sdk,
        base_url: "https://api.porter.in",
        api_key: "your-api-key",
        quote_impl: ExPorterSDK.Quote.Stub,
        order_impl: ExPorterSDK.Order.Stub

  Or set them temporarily in your tests:

      setup do
        previous_impls = %{
          quote: Application.get_env(:ex_porter_sdk, :quote_impl),
          order: Application.get_env(:ex_porter_sdk, :order_impl)
        }

        Application.put_env(:ex_porter_sdk, :quote_impl, ExPorterSDK.Quote.Stub)
        Application.put_env(:ex_porter_sdk, :order_impl, ExPorterSDK.Order.Stub)

        on_exit(fn ->
          Application.put_env(:ex_porter_sdk, :quote_impl, previous_impls.quote)
          Application.put_env(:ex_porter_sdk, :order_impl, previous_impls.order)
        end)

        :ok
      end

  ## Error Handling

  All operations return tagged tuples:

    * `{:ok, response}` - Successful operation with response data
    * `{:error, reason}` - Failed operation with error details

  Common error reasons include:
    * Invalid parameters
    * Authentication failures
    * Network issues
    * Resource not found
    * Server errors

  ## Links

    * [GitHub](https://github.com/yatender-oktalk/ex_porter_sdk)
    * [Documentation](https://hexdocs.pm/ex_porter_sdk)
    * [Porter API Documentation](https://porter.in/api-docs)
  """

  @doc """
  Returns the configured base URL for the Porter API.

  ## Raises

  RuntimeError if base_url is not configured.

  ## Examples

      iex> ExPorterSDK.base_url()
      "https://api.porter.in"

  """
  @spec base_url() :: String.t()
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

  ## Raises

  RuntimeError if api_key is not configured.

  ## Examples

      iex> ExPorterSDK.api_key()
      "your-api-key"

  """
  @spec api_key() :: String.t()
  def api_key do
    Application.get_env(:ex_porter_sdk, :api_key) ||
      raise """
      Porter SDK api_key not configured. Add to your config:

      config :ex_porter_sdk,
        api_key: "your-api-key"
      """
  end
end
