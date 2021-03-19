defmodule Fleet.Repo do
  use Ecto.Repo,
    otp_app: :fleet,
    #----------- Mysql
    # adapter: Ecto.Adapters.MySQL
    # adapter: Ecto.Adapters.MyXQL
    #----------- mssql
    # adapter: Tds.Ecto
    #----------- Postgres
    adapter: Ecto.Adapters.Postgres
end
