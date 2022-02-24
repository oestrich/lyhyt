import Config

config :lyhyt,
  ecto_repos: [Lyhyt.Repo]

config :logger, :console, format: "$time $metadata[$level] $message\n"

if File.exists?("config/#{Mix.env()}.exs") do
  import_config "#{Mix.env()}.exs"
end
