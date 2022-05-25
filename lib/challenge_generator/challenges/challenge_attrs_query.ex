defmodule ChallengeGenerator.Challenges.ChallengeAttrsQuery do
  @moduledoc """
  The `ChallengeAttrsQuery` module provides a consistent struct for creating the
  map attributes for the aggregation query in Mongo
  """
  alias ChallengeGenerator.Challenges.ChallengeAttrsQuery

  @type t :: %ChallengeAttrsQuery{
          title: BSON.Regex.t(),
          edabit_id: binary,
          author: BSON.Regex.t(),
          author_edabit_id: binary,
          min_difficulty: float,
          programming_language: binary,
          min_quality: float,
          tags: list(binary)
        }

  @enforce_keys [
    :title,
    :edabit_id,
    :author,
    :author_edabit_id,
    :min_difficulty,
    :programming_language,
    :min_quality,
    :tags
  ]
  defstruct [
    :title,
    :edabit_id,
    :author,
    :author_edabit_id,
    :min_difficulty,
    :programming_language,
    :min_quality,
    :tags
  ]

  @spec parse!(nil) :: nil
  defp parse!(nil), do: nil

  @spec parse!(binary) :: float
  defp parse!(string) do
    {value, _} = Float.parse(string)
    value
  end

  @spec regex_encode!(nil) :: nil
  defp regex_encode!(nil), do: nil

  @spec regex_encode!(binary) :: BSON.Regex.t()
  defp regex_encode!(string) do
    %BSON.Regex{
      pattern: string
    }
  end

  @spec list_decode!(nil) :: nil
  defp list_decode!(nil), do: nil

  @spec list_decode!(binary) :: list(binary)
  defp list_decode!(string) do
    with {:ok, tags} <- Jason.decode(string) do
      tags
    else
      _ -> nil
    end
  end

  @doc """
  This creates the main struct based on a map
  ## Parameters
    - map: the map to create the struct from
  """
  @spec create_query_from_map(map) :: ChallengeAttrsQuery.t()
  def create_query_from_map(attrs_map) do
    %ChallengeAttrsQuery{
      :title => regex_encode!(attrs_map["title"]) || nil,
      :edabit_id => attrs_map["edabit_id"] || nil,
      :author => regex_encode!(attrs_map["author"]) || nil,
      :author_edabit_id => attrs_map["author_edabit_id"] || nil,
      :min_difficulty => parse!(attrs_map["min_difficulty"]) || nil,
      :programming_language => attrs_map["programming_language"] || nil,
      :min_quality => parse!(attrs_map["min_quality"]) || nil,
      :tags => list_decode!(attrs_map["tags"]) || nil
    }
  end

  @doc """
  This creates a map from the main struct, discarding the nil values
  ## Parameters
    - challenge_attrs: The `ChallengeAttrsQuery` struct to create the map from
  """
  @spec create_match_map(ChallengeAttrsQuery.t()) :: map
  def create_match_map(challenge_attrs) do
    challenge_attrs
    |> Map.from_struct()
    |> Enum.filter(fn {_k, v} -> v != nil end)
    |> Enum.reduce(%{}, fn tuple, acc ->
      Map.merge(acc, create_map_from_tuple(tuple))
    end)
  end

  @spec create_map_from_tuple({atom, float}) :: map
  defp create_map_from_tuple({key, value}) when is_float(value) do
    new_key =
      key
      |> Atom.to_string()
      |> String.replace_leading("min_", "")

    %{
      "#{new_key}" => %{
        "$gt" => value
      }
    }
  end

  @spec create_map_from_tuple({atom, list(binary)}) :: map
  defp create_map_from_tuple({key, value}) when is_list(value) do
    new_key =
      key
      |> Atom.to_string()

    %{
      "#{new_key}" => %{
        "$in" => value
      }
    }
  end

  @spec create_map_from_tuple({atom, binary}) :: map
  defp create_map_from_tuple({key, value}) do
    new_key =
      key
      |> Atom.to_string()

    %{
      "#{new_key}" => value
    }
  end
end
