# ExPorterSDK

Elixir SDK for Porter delivery service API.

## Installation

Add to your mix.exs:

```elixir
def deps do
  [
    {:ex_porter_sdk, "~> 0.1.0"}
  ]
end
```

## Configuration

Add to your `config.exs`:

```elixir
config :ex_porter_sdk,
  base_url: "https://api.porter.in",  # Required
  api_key: "your-api-key"             # Required
```

## Usage

```elixir
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
      number: "9090909090"
    }
  }
})

# Track order
{:ok, tracking} = ExPorterSDK.Order.track(order["order_id"])

# Cancel order
{:ok, result} = ExPorterSDK.Order.cancel(order["order_id"], "customer request")
```

## Testing

The SDK includes stub implementations that can be used in your tests:

```elixir
defmodule YourApp.DeliveryTest do
  use ExUnit.Case
  
  setup do
    # Use stubs for testing
    Application.put_env(:ex_porter_sdk, :quote_impl, ExPorterSDK.Quote.Stub)
    Application.put_env(:ex_porter_sdk, :order_impl, ExPorterSDK.Order.Stub)
    :ok
  end

  test "creates delivery order" do
    {:ok, quote} = ExPorterSDK.Quote.get_quote(%{
      pickup_details: %{lat: 12.909728, lng: 77.600139},
      drop_details: %{lat: 12.897957, lng: 77.621197}
    })
    
    assert quote["quote_id"] == "test_quote_123"
    
    {:ok, order} = ExPorterSDK.Order.create(%{
      quote_id: quote["quote_id"],
      customer: %{
        name: "Test User",
        mobile: %{country_code: "+91", number: "9876543210"}
      }
    })
    
    assert order["order_id"] == "test_order_123"
    assert order["status"] == "created"
  end
end
```

## Available Operations

### Quote
- `get_quote/1` - Get delivery quote

### Order
- `create/1` - Create new order
- `track/1` - Track order status
- `cancel/2` - Cancel order with reason

## License

MIT

