defmodule ExPorterSDK.Protocols.ProtocolGenerator do
  @moduledoc """
  Generates a default protocol implementations for non-nested structures.
  """

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      alias ExPorterSDK.Protocols.Mappable

      @structs Keyword.get(opts, :structs, [])

      for struct <- @structs do
        # Generate Mappable implementation
        defimpl Mappable, for: struct do
          def to_map(struct) do
            Map.from_struct(struct)
          end
        end
      end
    end
  end
end
