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

  @doc """
  Creates a challenge.

  ## Examples

      iex> create_challenge(%{field: value})
      {:ok, %Challenge{}}

      iex> create_challenge(%{field: bad_value})
      {:error, ...}

  """
  def create_challenge(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a challenge.

  ## Examples

      iex> update_challenge(challenge, %{field: new_value})
      {:ok, %Challenge{}}

      iex> update_challenge(challenge, %{field: bad_value})
      {:error, ...}

  """
  def update_challenge(%Challenge{} = challenge, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Challenge.

  ## Examples

      iex> delete_challenge(challenge)
      {:ok, %Challenge{}}

      iex> delete_challenge(challenge)
      {:error, ...}

  """
  def delete_challenge(%Challenge{} = challenge) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking challenge changes.

  ## Examples

      iex> change_challenge(challenge)
      %Todo{...}

  """
  def change_challenge(%Challenge{} = challenge, _attrs \\ %{}) do
    raise "TODO"
  end
end
