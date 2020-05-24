defmodule FleetWeb.SessionController do
    use FleetWeb, :controller
  
    alias FleetWeb.UserController
    alias Fleet.Logs
    alias Fleet.Auth
    # alias Fleet.{Auth, Logs}

    plug(
      FleetWeb.Plugs.RequireAuth
      when action in [:signout]
  )
  
    def new(conn, _params) do
      conn = put_layout(conn, false)
      render(conn, "index.html")
    end
  
    def create(conn, params) do
      with {:error, _reason} <- UserController.get_user_by_email(String.trim(params["email"])) do
        conn
        |> put_flash(:error, "Email do not match")
        |> put_layout(false)
        |> render("index.html")
      else
        {:ok, user} ->
          with {:error, _reason} <- Auth.confirm_password(user, String.trim(params["password"])) do
            conn
            |> put_flash(:error, "Password do not match")
            |> put_layout(false)
            |> render("index.html")
          else
            {:ok, _} ->
              cond do
                user.status == 1 ->
                  {:ok, _} = Logs.create_user_logs(%{user_id: user.id, activity: "logged in"})
  
                  conn
                  |> put_session(:current_user, user.id)
                  |> put_session(:session_timeout_at, session_timeout_at())
                  |> redirect(to: Routes.user_path(conn, :dashboard))
  
                true ->
                  conn
                  |> put_status(405)
                  |> put_layout(false)
                  |> render(FleetWeb.ErrorView, :"405")
              end
          end
      end
    # rescue
    #   _ ->
    #     conn
    #     |> put_flash(:error, "An error occured. login failed")
    #     |> put_layout(false)
    #     |> render("index.html")
    end
  
    defp session_timeout_at do
      DateTime.utc_now() |> DateTime.to_unix() |> (&(&1 + 3_600)).()
    end
  
    def signout(conn, _params) do
      {:ok, _} = Logs.create_user_logs(%{user_id: conn.assigns.user.id, activity: "logged out"})
  
      conn
      |> configure_session(drop: true)
      |> redirect(to: Routes.session_path(conn, :new))
    rescue
      _ ->
        conn
        |> configure_session(drop: true)
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end
  