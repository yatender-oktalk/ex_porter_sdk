defmodule ExPorterSDK.Webhook do
  alias ExPorterSDK.Webhook.Impl

  def verify_webhook(config, params) do
    Impl.verify_webhook(config, params)
  end
end
