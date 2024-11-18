import Config

config :ex_porter_sdk,
  quote_impl: ExPorterSDK.Quote.Stub,
  order_impl: ExPorterSDK.Order.Stub
