defmodule ChallengeGeneratorWeb.ChallengeController do
  @moduledoc """
  This controller handles the challenge fetching and management
  """
  import Plug.Conn.Status, only: [code: 1]
  use ChallengeGeneratorWeb, :controller
  use PhoenixSwagger

  alias ChallengeGenerator.Challenges
  alias ChallengeGenerator.Challenges.Challenge

  action_fallback ChallengeGeneratorWeb.FallbackController

  def swagger_definitions do
    %{
      Challenge:
        swagger_schema do
          title("Challenge")
          description("A challenge in our application")

          properties do
            _id(
              :string,
              "Database ID",
              required: true,
              example: "62897f53029d36f47fdaf632"
            )

            edabit_challenge_id(
              :string,
              "Challenge ID",
              required: true,
              example: "6vSZmN66xhMRDX8YT"
            )

            author(
              :string,
              "Challenge Author",
              required: true,
              example: "rubens"
            )

            author_edabit_id(
              :string,
              "Author ID",
              required: true,
              example: "XhzKztoQYYQzZ2c7o"
            )

            raw_code(
              :string,
              "Raw Challenge Code",
              required: true
            )

            difficulty(
              :number,
              "Challenge Difficulty between 0 and 5",
              required: true,
              example: 2.5
            )

            raw_instructions(
              :string,
              "Challenge Instructions",
              required: true
            )

            raw_tests(
              :string,
              "Challenge Raw Tests",
              required: true
            )

            programming_language(
              :string,
              "Programming Language between python3, java and javascript",
              required: true,
              example: "python3"
            )

            quality(
              :number,
              "Challenge Quality from 0 to 5",
              required: true,
              example: 4.2
            )

            summary(
              :number,
              "Challenge Summary",
              required: true
            )

            tags(
              :array,
              "Challenge tags",
              required: true,
              items: %PhoenixSwagger.Schema{type: :string},
              example: ["math", "algorithms"]
            )

            title(
              :string,
              "Challenge Title",
              required: true,
              example: "Recursion: Length of a String"
            )
          end
        end
    }
  end

  @doc """
  If a GET is requested to the root path, we redirect to the API docs

  ## Parameters
    - conn: Phoenix default connection
  """
  def redirect_to_docs(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :docs_api))
  end

  swagger_path :index do
    get("/api/challenges")
    description("Get a random challenge, based on the provided parameters")
    tag("Challenges")

    parameters do
      title(
        :query,
        :string,
        "Challenge Title Regex",
        required: false,
        example: "ort$"
      )

      edabit_id(
        :query,
        :string,
        "Edabit Challenge ID",
        required: false,
        example: "6vSZmN66xhMRDX8YT"
      )

      author(
        :query,
        :string,
        "Challenge Author Regex",
        required: false,
        example: "^M"
      )

      author_edabit_id(
        :query,
        :string,
        "Author ID",
        required: false,
        example: "XhzKztoQYYQzZ2c7o"
      )

      min_difficulty(
        :query,
        :number,
        "Min Challenge Difficulty from 0 to 5",
        required: false,
        example: 2.5
      )

      programming_language(
        :query,
        :string,
        "Programming Language between python3, java and javascript",
        required: false,
        example: "python3"
      )

      min_quality(
        :query,
        :number,
        "Min Challenge Quality from 0 to 5",
        required: false,
        example: 4.2
      )

      tags(
        :query,
        :array,
        "Challenge tags to looks",
        required: false,
        items: %PhoenixSwagger.Schema{type: :string},
        example: ["math", "algorithms"]
      )
    end

    response(code(:ok), "Successful Response", Schema.ref(:Challenge))
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

  swagger_path :show do
    get("/api/challenges/{id}")
    description("Get a challenge by its ID")
    tag("Challenges")

    parameters do
      id(
        :path,
        :string,
        "Challenge DB ID",
        required: true,
        example: "ort$"
      )
    end

    response(code(:ok), "Successful Response", Schema.ref(:Challenge))
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
