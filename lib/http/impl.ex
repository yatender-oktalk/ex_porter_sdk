defmodule ExPorterSDK.Http.Impl do
  @moduledoc """
  HTTP client wrapper for Porter API.
  """

  require Logger

  @base_headers [
    {"content-type", "application/json"}
  ]

  def request(method, path, body \\ nil) do
    Logger.debug("Making Porter API request",
      method: method,
      path: path,
      body: sanitize_logs(body)
    )

    Req.new(
      base_url: ExPorterSDK.Config.base_url(),
      headers: @base_headers ++ [{"x-api-key", ExPorterSDK.Config.api_key()}]
    )
    |> Req.request(method: method, url: path, json: body)
    |> handle_response(method, path)
  end

  defp handle_response({:ok, %{status: 200, body: body}}, method, path) do
    Logger.info("Porter API request successful",
      method: method,
      path: path,
      status: 200
    )

    {:ok, body}
  end

  defp handle_response({:ok, %{status: status, body: body}}, method, path) do
    Logger.warning("Porter API request failed",
      method: method,
      path: path,
      status: status,
      error: body
    )

    {:error, %{status: status, message: body}}
  end

  defp handle_response({:error, error}, method, path) do
    Logger.error("Porter API request error",
      method: method,
      path: path,
      error: inspect(error)
    )

    {:error, error}
  end

  defp sanitize_logs(nil), do: nil

  defp sanitize_logs(body) when is_map(body) do
    body
    |> Map.drop(["customer_phone", "api_key"])
    |> Map.new(fn
      {k, v} when is_binary(v) and byte_size(v) > 100 ->
        {k, String.slice(v, 0..100) <> "..."}

      {k, v} ->
        {k, v}
    end)
  end
end
