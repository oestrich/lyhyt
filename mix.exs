defmodule Lyhyt.MixProject do
  use Mix.Project

  def project do
    [
      app: :lyhyt,
      version: "0.1.0",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Lyhyt.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:aino, github: "oestrich/aino"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.7"},
      {:postgrex, "~> 0.16.2"},
      {:vapor, "~> 0.10.0"}
    ]
  end

  defp aliases() do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
