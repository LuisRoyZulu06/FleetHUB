defmodule Fleet.Repo do
  use Ecto.Repo,
    otp_app: :fleet,
    #----------- mssql
    # adapter: Tds.Ecto
    #----------- Postgres
    adapter: Ecto.Adapters.Postgres
end
