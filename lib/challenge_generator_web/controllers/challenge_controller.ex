defmodule ChallengeGeneratorWeb.ChallengeController do
  use ChallengeGeneratorWeb, :controller

  alias ChallengeGenerator.Challenges
  alias ChallengeGenerator.Challenges.Challenge

  action_fallback ChallengeGeneratorWeb.FallbackController

  def redirect_to_docs(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :docs_api))
  end

  def index(conn, params) do
    challenge = Challenges.random_challenge(params)
    render(conn, "show.json", challenge: challenge)
  end

  def create(conn, %{"challenge" => challenge_params}) do
    with {:ok, %Challenge{} = challenge} <- Challenges.create_challenge(challenge_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.challenge_path(conn, :show, challenge))
      |> render("show.json", challenge: challenge)
    end
  end

  def show(conn, %{"id" => id}) do
    challenge = Challenges.get_challenge!(id)
    render(conn, "show.json", challenge: challenge)
  end

  def update(conn, %{"id" => id, "challenge" => challenge_params}) do
    challenge = Challenges.get_challenge!(id)

    with {:ok, %Challenge{} = challenge} <-
           Challenges.update_challenge(challenge, challenge_params) do
      render(conn, "show.json", challenge: challenge)
    end
  end

  def delete(conn, %{"id" => id}) do
    challenge = Challenges.get_challenge!(id)

    with {:ok, %Challenge{}} <- Challenges.delete_challenge(challenge) do
      send_resp(conn, :no_content, "")
    end
  end
end
