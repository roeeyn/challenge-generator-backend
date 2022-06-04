defmodule ChallengeGeneratorWeb.PageController do
  @moduledoc false
  use ChallengeGeneratorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def docs(conn, _params) do
    redirect(conn, external: "https://roeeyn.github.io/challenge-generator-backend")
  end
end
