defmodule TomeStats.Repo.Migrations.CreateSearchKeyValue do
  use Ecto.Migration

  def change do
    create table(:search_key_values) do
      add :name, :string
      add :search_key_id, references(:search_keys)

      timestamps
    end
    create index(:search_key_values, [:search_key_id])

  end
end
