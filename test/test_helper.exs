ExUnit.start()
# Set up test configuration to use Stubs by default
Application.put_env(:ex_porter_sdk, :base_url, "https://api.porter.test")
Application.put_env(:ex_porter_sdk, :api_key, "test_api_key")

Mox.defmock(ExPorterSDK.Quote.Stub, for: ExPorterSDK.Behaviours.Quote)
Mox.defmock(ExPorterSDK.Order.Stub, for: ExPorterSDK.Behaviours.Order)

Application.put_env(:ex_porter_sdk, :quote_impl, ExPorterSDK.Quote.Stub)
Application.put_env(:ex_porter_sdk, :order_impl, ExPorterSDK.Order.Stub)
