defmodule ChallengeGeneratorWeb.Router do
  @moduledoc false
  use ChallengeGeneratorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ChallengeGeneratorWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChallengeGeneratorWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/docs", PageController, :docs
  end

  scope "/api", ChallengeGeneratorWeb do
    pipe_through :api

    get "/", ChallengeController, :redirect_to_docs
    resources "/challenges", ChallengeController, except: [:new, :edit]
  end

  scope "/docs/api" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :challenge_generator,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      schemes: ["http", "https"],
      info: %{
        version: "1.0",
        title: "Challenge Generator API",
        description: "API Documentation for Challenge Generator",
        termsOfService: "Open for public",
        contact: %{
          name: "Rodrigo Medina",
          email: "rodrigo.medina.neri@gmail.com"
        }
      },
      consumes: ["application/json"],
      produces: ["application/json"],
      tags: [
        %{name: "Challenges", description: "Challenges resources"}
      ]
    }
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ChallengeGeneratorWeb.Telemetry
    end
  end
end
