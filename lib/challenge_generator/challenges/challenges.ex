defmodule ChallengeGenerator.Challenges do
  @moduledoc """
  The Challenges context.
  """

  alias ChallengeGenerator.Challenges.Challenge

  @doc """
  Returns a random challenge

  ## Examples

      iex> random_challenge()
      %Challenge{}

  """
  @spec random_challenge(map) :: Challenge.t()
  def random_challenge(param) do
    {:ok, challenge} = Challenge.get_random_challenge(param)
    challenge
  end

  @doc """
  Gets a single challenge.

  Raises if the Challenge does not exist.

  ## Examples

      iex> get_challenge!(123)
      %Challenge{}

  """
  @spec get_challenge!(binary | map) :: Challenge.t()
  def get_challenge!(param) do
    {:ok, challenge} = Challenge.get_challenge(param)
    challenge
  end

  @doc false
  def create_challenge(attrs \\ %{}) do
    raise "TODO"
  end

  @doc false
  def update_challenge(%Challenge{} = challenge, attrs) do
    raise "TODO"
  end

  @doc false
  def delete_challenge(%Challenge{} = challenge) do
    raise "TODO"
  end

  @doc false
  def change_challenge(%Challenge{} = challenge, _attrs \\ %{}) do
    raise "TODO"
  end
end
