defmodule Lyhyt.Repo do
  use Ecto.Repo,
    otp_app: :lyhyt,
    adapter: Ecto.Adapters.Postgres

  alias Lyhyt.Config

  def init(_type, config) do
    vapor_config = Vapor.load!(Config)
    database_config = vapor_config.database

    config =
      Keyword.merge(config,
        ssl: database_config.ssl,
        pool_size: database_config.pool_size,
        url: database_config.url
      )

    {:ok, config}
  end
end
