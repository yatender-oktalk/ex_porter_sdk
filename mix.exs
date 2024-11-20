defmodule ExPorterSDK.MixProject do
  use Mix.Project

  @version "0.1.0"
  @github_url "https://github.com/yatender-oktalk/ex_porter_sdk"

  def project do
    [
      app: :ex_porter_sdk,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "ExPorterSDK",
      source_url: @github_url,
      homepage_url: @github_url,
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:typed_struct, "~> 0.1.4"},
      {:req, "~> 0.5.7"},
      {:jason, "~> 1.4.0"},
      {:mox, "~> 1.0", only: :test},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    An Elixir SDK for Porter's delivery API, providing a simple and reliable way to integrate
    Porter's logistics services into your Elixir applications. Features include getting delivery
    quotes, creating and managing delivery orders, and real-time order tracking.
    """
  end

  defp package do
    [
      name: "ex_porter_sdk",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{
        "GitHub" => @github_url,
        "Changelog" => "#{@github_url}/blob/main/CHANGELOG.md",
        "Issues" => "#{@github_url}/issues"
      },
      maintainers: ["Yatender Singh"]
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @github_url,
      extras: [
        "README.md",
        "CHANGELOG.md",
        "LICENSE.md"
      ],
      groups_for_modules: [
        Core: [
          ExPorterSDK.Quote,
          ExPorterSDK.Order
        ],
        Behaviours: [
          ExPorterSDK.Behaviours.Quote,
          ExPorterSDK.Behaviours.Order
        ],
        "Test Stubs": [
          ExPorterSDK.Quote.Stub,
          ExPorterSDK.Order.Stub
        ]
      ]
    ]
  end
end
