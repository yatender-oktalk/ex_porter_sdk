defmodule ExPorterSDK.Protocols do
  defprotocol Mappable do
    @doc "Converts a struct to a map, handling nested structures"
    @spec to_map(struct()) :: map()
    def to_map(struct)
  end

  defprotocol Structable do
    @doc "Converts a map to a struct, handling nested structures"
    @spec from_map(map()) :: struct()
    def from_map(map)
  end

  defprotocol Validatable do
    @doc "Validates the structure and returns :ok or {:error, reason}"
    @spec validate(struct()) :: :ok | {:error, String.t()}
    @fallback_to_any true
    def validate(struct)
  end

  defimpl Validatable, for: Any do
    def validate(%{__struct__: struct} = data) do
      # Delegate to struct-specific implementation if it exists
      if function_exported?(struct, :validate_struct, 1) do
        struct.validate_struct(data)
      else
        # Default validation logic
        data
        |> Map.from_struct()
        |> Enum.find_value(:ok, fn {field, value} ->
          case value do
            nil -> {:error, "#{field} is required"}
            "" when is_binary(value) -> {:error, "#{field} cannot be empty"}
            _ -> nil
          end
        end)
      end
    end
  end
end
