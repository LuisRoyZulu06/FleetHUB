defmodule Fleet.Repo do
  use Ecto.Repo,
    otp_app: :fleet,
      # -------------------- Postgres
      adapter: Ecto.Adapters.Postgres

      # -------------------- mssql
      # adapter: Ecto.Adapters.Tds
end
