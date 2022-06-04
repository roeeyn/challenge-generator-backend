defmodule ChallengeGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :challenge_generator,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Docs
      name: "Challenge Generator",
      source_url: "https://github.com/roeeyn/challenge-generator-backend",
      homepage_url: "https://challenge-generator-backend.herokuapp.com/docs/api",
      docs: [
        source_ref: "master",
        authors: ["roeeyn"],
        groups_for_modules: [
          "Lib Logic": [
            ChallengeGenerator,
            ChallengeGenerator.Challenges,
            ChallengeGenerator.Challenges.Challenge,
            ChallengeGenerator.Challenges.ChallengeAttrsQuery
          ],
          "Web Interface": [ChallengeGeneratorWeb]
        ],
        nest_modules_by_prefix: [ChallengeGenerator, ChallengeGeneratorWeb],
        extras: ["README.md"]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ChallengeGenerator.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6.7"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:mongodb_driver, "~> 0.9.0"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:phoenix_swagger, "~> 0.8"},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      {:ex_json_schema, "~> 0.5"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end
end
