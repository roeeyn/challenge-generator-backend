defmodule ChallengeGeneratorWeb.ChallengeView do
  use ChallengeGeneratorWeb, :view
  alias ChallengeGeneratorWeb.ChallengeView

  def render("index.json", %{challenges: challenges}) do
    %{data: render_many(challenges, ChallengeView, "challenge.json")}
  end

  def render("show.json", %{challenge: challenge}) do
    %{data: render_one(challenge, ChallengeView, "challenge.json")}
  end

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
