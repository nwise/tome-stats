defmodule TomeStats.SearchKeyValue do
  use TomeStats.Web, :model

  @derive {Poison.Encoder, only: [:name, :inserted_at, :updated_at]}

  schema "search_key_values" do
    field :name, :string
    belongs_to :search_key, TomeStats.SearchKey

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
