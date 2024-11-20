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
- For detailed questions, please email [your-email]

## Acknowledgments

- [Porter API Documentation](https://porter.in/api-docs)
- All contributors to this project
```

And here's the CONTRIBUTING.md:

```markdown
# Contributing to ExPorterSDK

First off, thanks for taking the time to contribute! 🎉 👍

The following is a set of guidelines for contributing to ExPorterSDK. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [your-email].

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* Use a clear and descriptive title
* Describe the exact steps which reproduce the problem
* Provide specific examples to demonstrate the steps
* Describe the behavior you observed after following the steps
* Explain which behavior you expected to see instead and why
* Include stack traces and error messages

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* Use a clear and descriptive title
* Provide a step-by-step description of the suggested enhancement
* Provide specific examples to demonstrate the steps
* Describe the current behavior and explain which behavior you expected to see instead
* Explain why this enhancement would be useful

### Pull Requests

* Fork the repo and create your branch from `main`
* If you've added code that should be tested, add tests
* If you've changed APIs, update the documentation
* Ensure the test suite passes
* Make sure your code follows the existing style
* Write a good pull request description that explains your changes

## Development Setup

1. Fork and clone the repo
2. Run `mix deps.get` to install dependencies
3. Run `mix test` to run tests

## Styleguides

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

### Elixir Styleguide

* Use 2 spaces for indentation
* Limit lines to 98 characters
* Follow the style guide enforced by `mix format`
* Write documentation for all public functions
* Include @moduledoc and @doc attributes
* Use pipe operator |> when appropriate

### Documentation Styleguide

* Use [ExDoc](https://github.com/elixir-lang/ex_doc) for documentation
* Include code examples in documentation when possible
* Keep code examples short and relevant

## Testing

* Write test cases for all new functionality
* Ensure all tests pass before submitting PRs
* Use descriptive test names
* Follow the existing test structure

### Test Coverage

We strive to maintain high test coverage. Please ensure your contributions include appropriate tests.

## Additional Notes

### Issue and Pull Request Labels

This section lists the labels we use to help us track and manage issues and pull requests.

* `bug` - Issues for bugs in the code
* `documentation` - Issues for improving or updating documentation
* `enhancement` - Issues for new features or improvements
* `help wanted` - Issues where we need assistance
* `good first issue` - Good for newcomers

## Getting Help

If you need help, you can:

* Open an issue with your question
* Email the maintainers at [your-email]

## Recognition

Contributors who add significant value to the project will be recognized in our README.md file.

Thank you for contributing to ExPorterSDK! 🚀

[![Hex.pm](https://img.shields.io/hexpm/v/ex_porter_sdk.svg)](https://hex.pm/packages/ex_porter_sdk)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/ex_porter_sdk.svg)](https://hex.pm/packages/ex_porter_sdk)
[![Documentation](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/ex_porter_sdk)