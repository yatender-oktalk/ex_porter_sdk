defmodule ExPorterSDK.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_porter_sdk,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "ExPorterSDK",
      source_url: "https://github.com/yatender-oktalk/ex_porter_sdk"
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
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    A Porter SDK for Elixir. Add your detailed package description here.
    """
  end

  defp package do
    [
      name: "ex_porter_sdk",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/yatender-oktalk/ex_porter_sdk"
      },
      maintainers: ["Yatender Singh"]
    ]
  end
end
