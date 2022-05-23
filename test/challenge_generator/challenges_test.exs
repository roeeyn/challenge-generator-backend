defmodule ChallengeGenerator.ChallengesTest do
  use ChallengeGenerator.DataCase

  alias ChallengeGenerator.Challenges

  describe "challenges" do
    alias ChallengeGenerator.Challenges.Challenge

    import ChallengeGenerator.ChallengesFixtures

    @invalid_attrs %{author: nil, title: nil}

    test "list_challenges/0 returns all challenges" do
      challenge = challenge_fixture()
      assert Challenges.list_challenges() == [challenge]
    end

    test "get_challenge!/1 returns the challenge with given id" do
      challenge = challenge_fixture()
      assert Challenges.get_challenge!(challenge.id) == challenge
    end

    test "create_challenge/1 with valid data creates a challenge" do
      valid_attrs = %{author: "some author", title: "some title"}

      assert {:ok, %Challenge{} = challenge} = Challenges.create_challenge(valid_attrs)
      assert challenge.author == "some author"
      assert challenge.title == "some title"
    end

    test "create_challenge/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Challenges.create_challenge(@invalid_attrs)
    end

    test "update_challenge/2 with valid data updates the challenge" do
      challenge = challenge_fixture()
      update_attrs = %{author: "some updated author", title: "some updated title"}

      assert {:ok, %Challenge{} = challenge} = Challenges.update_challenge(challenge, update_attrs)
      assert challenge.author == "some updated author"
      assert challenge.title == "some updated title"
    end

    test "update_challenge/2 with invalid data returns error changeset" do
      challenge = challenge_fixture()
      assert {:error, %Ecto.Changeset{}} = Challenges.update_challenge(challenge, @invalid_attrs)
      assert challenge == Challenges.get_challenge!(challenge.id)
    end

    test "delete_challenge/1 deletes the challenge" do
      challenge = challenge_fixture()
      assert {:ok, %Challenge{}} = Challenges.delete_challenge(challenge)
      assert_raise Ecto.NoResultsError, fn -> Challenges.get_challenge!(challenge.id) end
    end

    test "change_challenge/1 returns a challenge changeset" do
      challenge = challenge_fixture()
      assert %Ecto.Changeset{} = Challenges.change_challenge(challenge)
    end
  end
end
