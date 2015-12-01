# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TomeStats.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TomeStats.Repo
alias TomeStats.SearchKey
alias TomeStats.SearchKeyValue

defmodule SearchKeyImporter do
  def persist_json({:ok, json_input}) do
    Enum.each(json_input, fn(json) -> create_search_key(json) end)
  end

  def create_search_key({key, values}) when is_list(values) do
    search_key = Repo.insert!(%SearchKey{name: key})
    Enum.each(values, fn(value) -> create_search_key_value(search_key.id, value) end)
  end

  def create_search_key({key, value}) when is_integer(value) do
    search_key = Repo.insert!(%SearchKey{name: key})
    create_search_key_value(search_key.id, Integer.to_string(value))
  end

  def create_search_key({key, value}) when is_boolean(value) do
    search_key = Repo.insert!(%SearchKey{name: key})
    case value do
      true ->
        create_search_key_value(search_key.id, "true")
      false ->
        create_search_key_value(search_key.id, "false")
    end
  end

  def create_search_key({key, value}) do
    search_key = Repo.insert!(%SearchKey{name: key})
    create_search_key_value(search_key.id, value)
  end

  def create_search_key_value(search_key_id, value) do
    Repo.insert!(%SearchKeyValue{name: value, search_key_id: search_key_id})
  end
end

case File.read("search_filters.json") do
  {:ok, json_input} ->
    Poison.decode(json_input)
    |> SearchKeyImporter.persist_json
  {:error, :enoent} ->
    Mix.shell.info "Invalid Filename"
end
