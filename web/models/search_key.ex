defmodule TomeStats.SearchKey do
  use TomeStats.Web, :model

  @derive {Poison.Encoder, only: [:name, :inserted_at, :updated_at]}

  schema "search_keys" do
    field :name, :string
    field :category, :string
    has_many :search_key_values, TomeStats.SearchKeyValue
    timestamps
  end

  @required_fields ~w(name category)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
