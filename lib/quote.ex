defmodule ExPorterSDK.Quote do
  alias ExPorterSDK.Quote.Impl

  def get_quote(config, params) do
    module().get_quote(config, params)
  end

  def module do
    Application.get_env(:ex_porter_sdk, :quote_impl, Impl)
  end
end
