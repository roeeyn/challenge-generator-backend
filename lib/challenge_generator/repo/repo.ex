defmodule ChallengeGenerator.Repo do
  use Mongo.Repo,
    otp_app: :challenge_generator,
    topology: :mongo
end
