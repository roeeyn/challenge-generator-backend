defmodule ChallengeGeneratorWeb.PageController do
  use ChallengeGeneratorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def docs(conn, _params) do
    render(conn, "index.html")
  end

  def docs_api(conn, _params) do
    render(conn, "index.html")
  end
end