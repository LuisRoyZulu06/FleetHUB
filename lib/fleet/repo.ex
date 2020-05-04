defmodule Fleet.Repo do
  use Ecto.Repo,
    otp_app: :fleet,
    adapter: Tds.Ecto
    # adapter: Ecto.Adapters.Postgres
end
