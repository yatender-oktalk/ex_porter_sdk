defmodule ExPorterSDK.Behaviours.Quote do
  @callback get_quote(params :: map()) :: {:ok, map()} | {:error, map()}
end
