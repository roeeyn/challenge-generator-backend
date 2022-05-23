defmodule ChallengeGenerator.Challenges.Challenge do
  use Mongo.Collection

  alias ChallengeGenerator.Challenges.Challenge

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

  @spec get_by_id(binary) :: {:ok, Challenge.t()} | {:error, binary}
  def get_by_id(id) do
    with {:ok, object_id} <- BSON.ObjectId.decode(id) do
      challenge =
        :mongo
        |> Mongo.find_one(@collection, %{@id => object_id})
        |> load()

      {:ok, challenge}
    else
      _ -> {:error, "Invalid ID"}
    end
  end
end
