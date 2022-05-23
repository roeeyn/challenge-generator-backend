defmodule ChallengeGenerator.ChallengesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChallengeGenerator.Challenges` context.
  """

  @doc """
  Generate a challenge.
  """
  def challenge_fixture(attrs \\ %{}) do
    {:ok, challenge} =
      attrs
      |> Enum.into(%{
        author: "some author",
        title: "some title"
      })
      |> ChallengeGenerator.Challenges.create_challenge()

    challenge
  end
end
