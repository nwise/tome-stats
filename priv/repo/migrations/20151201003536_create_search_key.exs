defmodule TomeStats.Repo.Migrations.CreateSearchKey do
  use Ecto.Migration

  def change do
    create table(:search_keys) do
      add :name, :string
      add :category, :string

      timestamps
    end

  end
end
