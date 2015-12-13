defmodule TomeStats.Results do

  defstruct results: [], search_url: 'none'

  def search(search_params) do
    search_params
    |> construct_search_url
    |> get_search_results
  end

  def construct_search_url(search_params) do
    search_params
    |> convert_params_to_query_string
    |> concat_query_with_base
  end

  def get_search_results(search_url) do
    results = HTTPotion.get(search_url) \
              |> Poison.decode!
    %TomeStats.Results{results: results, search_url: search_url}
  end

  def convert_params_to_query_string(search_params) do
    search_params
    |> Enum.reject(fn({k,v}) -> String.length(v) <= 0 end )
    |> Enum.map(fn({k,v}) -> (k <> "=" <> v) end )
    |> Enum.join("&")
  end

  defp concat_query_with_base(query_string) do
    URI.encode("http://zigur.te4.org/138884/afa509da-7308-4de5-a378-5c1750850def/characters/find?" <> query_string)
  end
end
