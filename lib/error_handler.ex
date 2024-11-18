defmodule ExPorterSDK.ErrorHandler do
  require Logger

  def handle_response({:ok, %{status: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({:ok, %{status: status, body: body}}) when status in 400..499 do
    Logger.warning("Client error in request",
      status: status,
      error: body
    )

    {:error, %{status: status, message: body}}
  end

  def handle_response({:ok, %{status: status, body: body}}) when status in 500..599 do
    Logger.error("Server error in request",
      status: status,
      error: body
    )

    {:error, %{status: status, message: body}}
  end

  def handle_response({:error, %Req.Error{reason: reason}}) do
    Logger.error("Request error",
      error: inspect(reason)
    )

    {:error, %{status: :network_error, message: "Network or connection error"}}
  end

  def handle_response({:error, error}) do
    Logger.error("Unexpected error",
      error: inspect(error)
    )

    {:error, %{status: :unknown_error, message: "An unexpected error occurred"}}
  end
end
