defmodule Lyhyt.Application do
  @moduledoc false

  use Application

  alias Lyhyt.Config

  @impl true
  def start(_type, _args) do
    config = Vapor.load!(Config).application

    children = [
      {Lyhyt.Repo, []},
      aino(config)
    ]

    children = Enum.reject(children, &is_nil/1)

    opts = [strategy: :one_for_one, name: Lyhyt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Only boot Aino outside of tests
  defp aino(config) do
    case config.environment != "test" do
      true ->
        aino_config = %Aino.Config{
          callback: Lyhyt.Web.Handler,
          otp_app: :lyhyt,
          port: config.port,
          host: config.host,
          url_port: config.url_port,
          url_scheme: config.url_scheme,
          environment: config.environment,
          config: %{
            session_salt: config.session_salt
          }
        }

        {Aino, aino_config}

      false ->
        nil
    end
  end
end
