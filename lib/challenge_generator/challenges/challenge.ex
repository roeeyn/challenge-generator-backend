defmodule ChallengeGenerator.Challenges.Challenge do
  @moduledoc """
  This module defines the Challenge collection and struct.
  """
  use Mongo.Collection
  require Logger

  alias ChallengeGenerator.Challenges.Challenge
  alias ChallengeGenerator.Challenges.ChallengeAttrsQuery

  # only to suppress warnings
  @collection nil

  collection "challenges" do
    attribute(:edabit_id, String.t())
    attribute(:author, String.t())
    attribute(:author_edabit_id, String.t())
    attribute(:raw_code, String.t())
    attribute(:difficulty, String.t())
    attribute(:raw_instructions, String.t())
    attribute(:raw_tests, String.t())
    attribute(:programming_language, String.t())
    attribute(:quality, String.t())
    attribute(:summary, String.t())
    attribute(:tags, list(String.t()))
    attribute(:title, String.t())
  end

  @doc """
  Get a challenge based on an ObjectID

  ## Parameters
    - binary | map: The ObjectID value, or the map of attributes
  """
  @spec get_challenge(binary) :: {:ok, Challenge.t()}
  def get_challenge(id) when is_binary(id) do
    Logger.debug("Getting challenge by ID:" <> id)

    with {:ok, object_id} <- BSON.ObjectId.decode(id) do
      challenge =
        :mongo
        |> Mongo.find_one(@collection, %{@id => object_id})
        |> load()

      {:ok, challenge}
    else
      _ -> {:ok, nil}
    end
  end

  @spec get_challenge(map) :: {:ok, Challenge.t()}
  def get_challenge(challenge_attrs) do
    Logger.debug("Getting challenge by attrs:" <> inspect(challenge_attrs))

    challenge =
      :mongo
      |> Mongo.find_one(@collection, challenge_attrs)
      |> load()

    {:ok, challenge}
  end

  @doc """
  Get a random challenge based on a map of attributes
  ## Parameters
    - map: The map of attributes based on ChallengeAttrsQuery struct
  """
  @spec get_random_challenge(map) :: {:ok, Challenge.t()}
  def get_random_challenge(attrs \\ %{}) do
    Logger.debug("Getting random challenge by attrs:" <> inspect(attrs))

    match_map =
      ChallengeAttrsQuery.create_query_from_map(attrs)
      |> ChallengeAttrsQuery.create_match_map()

    challenge =
      :mongo
      |> Mongo.aggregate(@collection, [
        %{"$match" => match_map},
        %{"$sample" => %{"size" => 1}}
      ])
      |> Enum.to_list()
      # As we're only having a sample with one element
      |> Enum.at(0)
      |> load()

    {:ok, challenge}
  end
end
