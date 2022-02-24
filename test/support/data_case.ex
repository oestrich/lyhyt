defmodule Lyhyt.DataCase do
  @moduledoc """
  A test case for tests that interact with the database.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Lyhyt.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Lyhyt.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Lyhyt.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Lyhyt.Repo, {:shared, self()})
    end

    :ok
  end
end
