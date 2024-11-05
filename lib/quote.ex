defmodule ExPorterSDK.Quote do
  alias ExPorterSDK.Quote.Impl

  def get_quote(config, params) do
    Impl.get_quote(config, params)
  end
end
