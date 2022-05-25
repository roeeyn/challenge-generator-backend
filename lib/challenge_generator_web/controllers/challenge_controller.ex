defmodule ChallengeGeneratorWeb.ChallengeController do
  @moduledoc """
  This controller handles the challenge fetching and management
  """
  use ChallengeGeneratorWeb, :controller

  alias ChallengeGenerator.Challenges
  alias ChallengeGenerator.Challenges.Challenge

  action_fallback ChallengeGeneratorWeb.FallbackController

  @doc """
  If a GET is requested to the root path, we redirect to the API docs

  ## Parameters
    - conn: Phoenix default connection
  """
  def redirect_to_docs(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :docs_api))
  end

  @doc """
  If a GET is requested to the root path, we redirect to the API docs

  ## Parameters
    - conn: Phoenix default connection
  """
  def index(conn, params) do
    challenge = Challenges.random_challenge(params)
    render(conn, "show.json", challenge: challenge)
  end

  @doc false
  def create(conn, %{"challenge" => challenge_params}) do
    with {:ok, %Challenge{} = challenge} <- Challenges.create_challenge(challenge_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.challenge_path(conn, :show, challenge))
      |> render("show.json", challenge: challenge)
    end
  end

  @doc """
  If a GET is requestes with the ID in the path, we return the challenge

  ## Parameters
    - conn: Phoenix default connection
    - id: ID of the challenge
  """
  def show(conn, %{"id" => id}) do
    challenge = Challenges.get_challenge!(id)
    render(conn, "show.json", challenge: challenge)
  end

  @doc false
  def update(conn, %{"id" => id, "challenge" => challenge_params}) do
    challenge = Challenges.get_challenge!(id)

    with {:ok, %Challenge{} = challenge} <-
           Challenges.update_challenge(challenge, challenge_params) do
      render(conn, "show.json", challenge: challenge)
    end
  end

  @doc false
  def delete(conn, %{"id" => id}) do
    challenge = Challenges.get_challenge!(id)

    with {:ok, %Challenge{}} <- Challenges.delete_challenge(challenge) do
      send_resp(conn, :no_content, "")
    end
  end
end
