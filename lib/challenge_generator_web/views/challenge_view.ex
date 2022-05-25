defmodule ChallengeGeneratorWeb.ChallengeView do
  @moduledoc """
  This is where the jsons are generated based on the challenge struct
  """
  use ChallengeGeneratorWeb, :view
  alias ChallengeGeneratorWeb.ChallengeView
  alias ChallengeGenerator.Challenges.Challenge

  @typedoc """
  This is the struct the result JSON will be based on
  """
  @type json_challenge() :: %{
          _id: String.t(),
          edabit_id: String.t(),
          author: String.t(),
          author_edabit_id: String.t(),
          raw_code: String.t(),
          difficulty: float(),
          raw_instructions: String.t(),
          raw_tests: String.t(),
          programming_language: String.t(),
          quality: float(),
          summary: String.t(),
          tags: [String.t()],
          title: String.t()
        }

  @doc """
  Generates a result list of JSON based on a list of `Challenge` structs
  """
  @spec render(binary, %{challenges: [Challenge.t()]}) :: %{data: [json_challenge()]}
  def render("index.json", %{challenges: challenges}) do
    %{data: render_many(challenges, ChallengeView, "challenge.json")}
  end

  @doc """
  Generates a result JSON based on a `Challenge` struct
  """
  @spec render(binary, %{challenge: Challenge.t()}) :: %{data: json_challenge()}
  def render("show.json", %{challenge: challenge}) do
    %{data: render_one(challenge, ChallengeView, "challenge.json")}
  end

  @doc """
  Generates the JSON based on the `Challenge` struct
  """
  @spec render(binary, %{challenge: Challenge.t()}) :: json_challenge()
  def render("challenge.json", %{challenge: challenge}) do
    %{
      _id: BSON.ObjectId.encode!(challenge._id),
      edabit_id: challenge.edabit_id,
      author: challenge.author,
      author_edabit_id: challenge.author_edabit_id,
      raw_code: challenge.raw_code,
      difficulty: challenge.difficulty,
      raw_instructions: challenge.raw_instructions,
      raw_tests: challenge.raw_tests,
      programming_language: challenge.programming_language,
      quality: challenge.quality,
      summary: challenge.summary,
      tags: challenge.tags,
      title: challenge.title
    }
  end
end
