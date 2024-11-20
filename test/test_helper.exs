# test/test_helper.exs
ExUnit.start()
# Set up test configuration to use Stubs by default
Application.put_env(:ex_porter_sdk, :base_url, "https://api.porter.in")
Application.put_env(:ex_porter_sdk, :api_key, "your-api-key")

Mox.defmock(ExPorterSDK.Quote.Stub, for: ExPorterSDK.Behaviours.Quote)
Mox.defmock(ExPorterSDK.MockOrder, for: ExPorterSDK.Behaviours.Order)

Application.put_env(:ex_porter_sdk, :quote_impl, ExPorterSDK.Quote.Stub)
Application.put_env(:ex_porter_sdk, :order_impl, ExPorterSDK.Order.Stub)
