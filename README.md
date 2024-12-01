# ExPorterSDK

[![Hex.pm](https://img.shields.io/hexpm/v/ex_porter_sdk.svg)](https://hex.pm/packages/ex_porter_sdk)
[![Docs](https://img.shields.io/badge/hex-docs-green.svg)](https://hexdocs.pm/ex_porter_sdk)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)

An Elixir SDK for [Porter](https://porter.in)'s delivery API, providing a simple and reliable way to integrate Porter's logistics services into your Elixir applications.

## Features

- 🚚 Get delivery quotes based on locations
- 📦 Create and manage delivery orders
- 🔍 Track order status in real-time
- ⚡ Simple and intuitive API
- 🧪 Comprehensive test coverage
- 📚 Well-documented codebase

## Installation

Add `ex_porter_sdk` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_porter_sdk, "~> 0.1.0"}
  ]
end
```

## Configuration

Configure the SDK in your `config.exs`:

```elixir
config :ex_porter_sdk,
  base_url: System.get_env("PORTER_BASE_URL", "https://api.porter.in"),
  api_key: System.get_env("PORTER_API_KEY")
```

## Quick Start

### Get Delivery Quote

```elixir
params = %{
  pickup_details: %{lat: 12.909728534457143, lng: 77.6001397394293},
  drop_details: %{lat: 12.89795704454522, lng: 77.62119799020186},
  customer: %{
    name: "Test User",
    mobile: %{number: "7678139714", country_code: "+91"}
  }
}

{:ok, response} = ExPorterSDK.Quote.get_quote(params)
```

### Create Order

```elixir
order_params = %{
  request_id: "unique-request-id",
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

{:ok, response} = ExPorterSDK.Order.create(order_params)
```

### Track Order

```elixir
{:ok, status} = ExPorterSDK.Order.track("order_id")
```

### Cancel Order

```elixir
{:ok, response} = ExPorterSDK.Order.cancel("order_id")
```

## Documentation

Detailed documentation is available at [https://hexdocs.pm/ex_porter_sdk](https://hexdocs.pm/ex_porter_sdk).

## Testing

The SDK includes comprehensive tests. Run them with:

```bash
mix test
```

For development and testing, use the provided stubs:

```elixir
# config/test.exs
config :ex_porter_sdk,
  quote_impl: ExPorterSDK.Quote.Stub,
  order_impl: ExPorterSDK.Order.Stub
```

## Contributing

We appreciate all contributions. See our [Contributing Guide](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Support

- Open an issue for bug reports or feature requests
- For detailed questions, please email `yatender[dot]nitk[at]gmail[dot]com`

## Acknowledgments

- [Porter API Documentation](https://porter.in/api-docs)
- All contributors to this project
