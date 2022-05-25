defmodule ChallengeGenerator.Challenges.ChallengeAttrsQuery do
  alias ChallengeGenerator.Challenges.ChallengeAttrsQuery

  @type t :: %ChallengeAttrsQuery{
          title: binary,
          edabit_id: binary,
          author: binary,
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

  @spec create_query_from_map(map) :: ChallengeAttrsQuery.t()
  def create_query_from_map(attrs_map) do
    %ChallengeAttrsQuery{
      :title => attrs_map["title"] || nil,
      :edabit_id => attrs_map["edabit_id"] || nil,
      :author => attrs_map["author"] || nil,
      :author_edabit_id => attrs_map["author_edabit_id"] || nil,
      :min_difficulty => attrs_map["min_difficulty"] || nil,
      :programming_language => attrs_map["programming_language"] || nil,
      :min_quality => attrs_map["min_quality"] || nil,
      :tags => attrs_map["tags"] || nil
    }
  end

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
      "#{new_key}" => "#{value}"
    }
  end
end
