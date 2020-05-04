defmodule FleetWeb.UserController do
    use FleetWeb, :controller
    import Ecto.Query, warn: false
    alias Fleet.{Logs, Repo, Logs.UserLogs, Auth}
    alias Fleet.Drivers
    alias Fleet.Accounts
    alias Fleet.Accounts.User
    alias Fleet.Emails.Email
    alias FleetWeb.UserController
    alias Fleet.Drivers.IssueLoger
    alias Fleet.Clients.Contacts
    alias Fleet.Clients
    alias Fleet.Vehicles
    alias Fleet.Vehicles.VehicleDetails
  
    plug(
      FleetWeb.Plugs.RequireAuth
      when action in [
             :new,
             :dashboard,
             :change_password,
             :new_password,
             :list_users,
             :edit,
             :delete,
             :user_logs,
             :update,
             :create,
             :update_status,
             :user_actitvity,
             :user_mgt,
             :create_user,
             :edit_user,
             :update_user,
             :delete_user,
             :deactivate_user,
             :deactivate_user_account
           ]
    )
  
    plug(
      FleetWeb.Plugs.EnforcePasswordPolicy
      when action not in [:new_password, :change_password]
    )
  
    plug(
      FleetWeb.Plugs.RequireAdminAccess
      when action not in [:new_password, :change_password, :dashboard, :user_actitvity, :user_mgt, :create_user, :edit_user, :update_user, :delete_user, :deactivate_user, :deactivate_user_account]
    )
  
  
    def list_users(conn, _params) do
      users =
        Accounts.get_user()
        |> Enum.map(&%{&1 | id: sign_user_id(conn, &1.id)})
  
      page = %{first: "Users", last: "System users"}
      render(conn, "list_users.html", users: users, page: page)
    end
  
    def dashboard(conn, _params) do
      accounts = Accounts.list_tbl_users()
      issues = Drivers.list_tbl_vehicle_issue()
      vendors = Clients.list_tbl_vendors()
      list_vehicles = Vehicles.list_tbl_vehicles()
      render(conn, "index.html", accounts: accounts, issues: issues, vendors: vendors, list_vehicles: list_vehicles)
    end
  
    def user_actitvity(conn, %{"id" => user_id}) do
      with :error <- confirm_token(conn, user_id) do
        conn
        |> put_flash(:error, "invalid token received")
        |> redirect(to: Routes.user_path(conn, :list_users))
      else
        {:ok, user} ->
          user_logs = Logs.get_user_logs_by(user.id)
          page = %{first: "Users", last: "Activity logs"}
          render(conn, "activity_logs.html", user_logs: user_logs, page: page)
      end
    end
  
    def activity_logs(conn, _params) do
      results = Logs.get_all_activity_logs()
      page = %{first: "Users", last: "Activity logs"}
      render(conn, "activity_logs.html", user_logs: results, page: page)
    end
  
    def update_status(conn, %{"id" => id, "status" => status}) do
      with :error <- confirm_token(conn, id) do
        conn
        |> put_flash(:error, "invalid token received")
        |> redirect(to: Routes.user_path(conn, :list_users))
      else
        {:ok, user} ->
          User.changeset(user, %{status: status})
          |> prepare_status_change(conn, user, status)
          |> Repo.transaction()
          |> case do
            {:ok, %{user: _user, user_log: _user_log}} ->
              conn
              |> put_flash(:info, "Changes applied successfully.")
              |> redirect(to: Routes.user_path(conn, :list_users))
  
            {:error, _failed_operation, failed_value, _changes_so_far} ->
              reason = traverse_errors(failed_value.errors) |> List.first()
  
              conn
              |> put_flash(:error, reason)
              |> redirect(to: Routes.user_path(conn, :list_users))
          end
      end
    end
  
    defp prepare_status_change(changeset, conn, user, status) do
      Ecto.Multi.new()
      |> Ecto.Multi.update(:user, changeset)
      |> Ecto.Multi.insert(
        :user_log,
        User_log.changeset(
          %UserLogs{},
          %{
            user_id: conn.assigns.user.id,
            activity: """
            #{
              case status,
                do:
                  (
                    "1" -> "Activated"
                    _ -> "Disabled"
                  )
            }
            #{user.first_name} #{user.last_name}
            """
          }
        )
      )
    end
  
    def edit(conn, %{"id" => id}) do
      with :error <- confirm_token(conn, id) do
        conn
        |> put_flash(:error, "invalid token received")
        |> redirect(to: Routes.user_path(conn, :list_users))
      else
        {:ok, user} ->
          user = %{user | id: sign_user_id(conn, user.id)}
          page = %{first: "Users", last: "Edit user"}
          render(conn, "edit.html", result: user, page: page)
      end
    end
  
    def update(conn, %{"user" => user_params}) do
      with :error <- confirm_token(conn, user_params["id"]) do
        conn
        |> put_flash(:error, "invalid token received")
        |> redirect(to: Routes.user_path(conn, :list_users))
      else
        {:ok, user} ->
          Ecto.Multi.new()
          |> Ecto.Multi.update(:update, User.changeset(user, Map.delete(user_params, "id")))
          |> Ecto.Multi.run(:log, fn %{update: _update} ->
            activity =
              "Modified user details with Email \"#{user.email}\" and First Name \"#{
                user.first_name
              }\""
  
            user_log = %{
              user_id: conn.assigns.user.id,
              activity: activity
            }
  
            User_log.changeset(%UserLogs{}, user_log)
            |> Repo.insert()
          end)
          |> Repo.transaction()
          |> case do
            {:ok, %{update: _update, log: _log}} ->
              conn
              |> put_flash(:info, "Changes applied successfully!")
              |> redirect(to: Routes.user_path(conn, :edit, id: user_params["id"]))
  
            {:error, _failed_operation, failed_value, _changes_so_far} ->
              reason = traverse_errors(failed_value.errors) |> List.first()
  
              conn
              |> put_flash(:error, reason)
              |> redirect(to: Routes.user_path(conn, :edit, id: user_params["id"]))
          end
      end
    rescue
      _ ->
        conn
        |> put_flash(:error, "An error occurred, reason unknown")
        |> redirect(to: Routes.user_path(conn, :list_users))
    end
  
    # def new(conn, _params) do
    #   render(conn, "new.html", page: %{first: "Users", last: "New user"})
    # end
  
    def create(conn, %{"user" => user_params}) do
      pwd = random_string(6)
      user_params = Map.put(user_params, "password", pwd)
  
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:user, User.changeset(%User{user_id: conn.assigns.user.id}, user_params))
      |> Ecto.Multi.run(:user_log, fn %{user: user} ->
        activity =
          "Created new user with Email \"#{user.email}\" and First Name #{user.first_name}\""
  
        user_log = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }
  
        User_log.changeset(%UserLogs{}, user_log)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{user: user, user_log: _user_log}} ->
          Email.password(pwd, user.email)
  
          conn
          |> put_flash(
            :info,
            "#{String.capitalize(user.first_name)} created successfully and password is: #{pwd}"
          )
          |> redirect(to: Routes.user_path(conn, :list_users))
  
        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()
  
          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.user_path(conn, :list_users))
      end
    rescue
      _ ->
        conn
        |> put_flash(:error, "An error occurred, reason unknown. try again")
        |> redirect(to: Routes.user_path(conn, :list_users))
    end
  
    def delete(conn, %{"id" => id}) do
      user = Accounts.get_user!(id)
  
      Ecto.Multi.new()
      |> Ecto.Multi.delete(:user, user)
      |> Ecto.Multi.run(:user_log, fn %{user: user} ->
        activity = "Deleted user with Email \"#{user.email}\" and First Name \"#{user.first_name}\""
  
        user_log = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }
  
        User_log.changeset(%UserLogs{}, user_log)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{user: user, user_log: _user_log}} ->
          conn
          |> put_flash(:info, "#{String.capitalize(user.first_name)} deleted successfully.")
          |> redirect(to: Routes.user_path(conn, :list_users))
  
        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()
  
          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.user_path(conn, :list_users))
      end
    end
  
    def get_user_by_email(email) do
      case Repo.get_by(User, email: email) do
        nil -> {:error, "invalid email address"}
        user -> {:ok, user}
      end
    end
  
    def get_user_by(nt_username) do
      case Repo.get_by(User, nt_username: nt_username) do
        nil -> {:error, "invalid username/password"}
        user -> {:ok, user}
      end
    end
  
    defp sign_user_id(conn, id),
      do: Phoenix.Token.sign(conn, "user salt", id, signed_at: System.system_time(:second))
  
    # ------------------ Password Reset ---------------------
    def new_password(conn, _params) do
      page = %{first: "Settings", last: "Change password"}
      render(conn, "change_password.html", page: page)
    end
  
    def forgot_password(conn, _params) do
      conn
      |> put_layout(false)
      |> render("forgot_password.html")
    end
  
    def token(conn, %{"user" => user_params}) do
      with {:error, reason} <- get_user_by_email(user_params["email"]) do
        conn
        |> put_flash(:error, reason)
        |> redirect(to: Routes.user_path(conn, :forgot_password))
      else
        {:ok, user} ->
          token =
            Phoenix.Token.sign(conn, "user salt", user.id, signed_at: System.system_time(:second))
  
          Email.confirm_password_reset(token, user.email)
  
          conn
          |> put_flash(:info, "We have sent you a mail")
          |> redirect(to: Routes.session_path(conn, :new))
      end
    end
  
    defp confirm_token(conn, token) do
      case Phoenix.Token.verify(conn, "user salt", token, max_age: 86400) do
        {:ok, user_id} ->
          user = Repo.get!(User, user_id)
          {:ok, user}
  
        {:error, _} ->
          :error
      end
    end
  
    def default_password(conn, %{"token" => token}) do
      with :error <- confirm_token(conn, token) do
        conn
        |> put_flash(:error, "Invalid/Expired token")
        |> redirect(to: Routes.user_path(conn, :forgot_password))
      else
        {:ok, user} ->
          pwd = random_string(6)
  
          case Accounts.update_user(user, %{password: pwd, auto_password: "Y"}) do
            {:ok, _user} ->
              Email.password_alert(user.email, pwd)
  
              conn
              |> put_flash(:info, "Password reset successful")
              |> redirect(to: Routes.session_path(conn, :new))
  
            {:error, _reason} ->
              conn
              |> put_flash(:error, "An error occured, try again!")
              |> redirect(to: Routes.user_path(conn, :forgot_password))
          end
      end
    end
  
    def reset_pwd(conn, %{"id" => id}) do
      with :error <- confirm_token(conn, id) do
        conn
        |> put_flash(:error, "invalid token received")
        |> redirect(to: Routes.user_path(conn, :list_users))
      else
        {:ok, user} ->
          pwd = random_string(6)
          changeset = User.changeset(user, %{password: pwd, auto_password: "Y"})
  
          Ecto.Multi.new()
          |> Ecto.Multi.update(:user, changeset)
          |> Ecto.Multi.insert(
            :user_log,
            User_log.changeset(
              %UserLogs{},
              %{
                user_id: conn.assigns.user.id,
                activity: """
                Reserted account password for user with mail \"#{user.email}\"
                """
              }
            )
          )
          |> Repo.transaction()
          |> case do
            {:ok, %{user: user, user_log: _user_log}} ->
              Email.password(user.email, pwd)
              conn |> json(%{"info" => "Password changed to: #{pwd}"})
  
            # conn |> json(%{"info" => "Password changed successfully"})
  
            {:error, _failed_operation, failed_value, _changes_so_far} ->
              reason = traverse_errors(failed_value.errors) |> List.first()
              conn |> json(%{"error" => reason})
          end
      end
    end
  
    def change_password(conn, %{"user" => user_params}) do
      case confirm_old_password(conn, user_params) do
        false ->
          conn
          |> put_flash(:error, "some fields were submitted empty!")
          |> redirect(to: Routes.user_path(conn, :new_password))
  
        result ->
          with {:error, reason} <- result do
            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.user_path(conn, :new_password))
          else
            {:ok, _} ->
              conn.assigns.user
              |> change_pwd(user_params)
              |> Repo.transaction()
              |> case do
                {:ok, %{update: _update, insert: _insert}} ->
                  conn
                  |> put_flash(:info, "Password changed successful")
                  |> redirect(to: Routes.user_path(conn, :new_password))
  
                {:error, _failed_operation, failed_value, _changes_so_far} ->
                  reason = traverse_errors(failed_value.errors) |> List.first()
  
                  conn
                  |> put_flash(:error, reason)
                  |> redirect(to: Routes.user_path(conn, :new_password))
              end
          end
      end
    rescue
      _ ->
        conn
        |> put_flash(:error, "Password changed with errors")
        |> redirect(to: Routes.user_path(conn, :new_password))
    end
  
    def change_pwd(user, user_params) do
      pwd = String.trim(user_params["new_password"])
  
      Ecto.Multi.new()
      |> Ecto.Multi.update(:update, User.changeset(user, %{password: pwd, auto_password: "N"}))
      |> Ecto.Multi.insert(
        :insert,
        User_log.changeset(
          %UserLogs{},
          %{user_id: user.id, activity: "changed account password"}
        )
      )
    end
  
    defp confirm_old_password(
           conn,
           %{"old_password" => pwd, "new_password" => new_pwd}
         ) do
      with true <- String.trim(pwd) != "",
           true <- String.trim(new_pwd) != "" do
        Auth.confirm_password(
          conn.assigns.user,
          String.trim(pwd)
        )
      else
        false -> false
      end
    end
  
    # ------------------ / password reset -------------------
  
    def traverse_errors(errors) do
      for {key, {msg, _opts}} <- errors, do: "#{key} #{msg}"
    end
  
    def default_dashboard do
      today = Date.utc_today()
      days = Date.days_in_month(today)
  
      Date.range(%{today | day: 1}, %{today | day: days})
      |> Enum.map(&%{count: 0, day: "#{&1}", status: nil})
    end
  
    def random_string(length) do
      :crypto.strong_rand_bytes(length)
      |> Base.url_encode64()
      |> binary_part(0, length)
    end

    # ----------------------- / user management ---------------
    def user_mgt(conn, _params) do
      list_drivers  = Drivers.list_tbl_drivers()
      system_users = Accounts.list_tbl_users()
      render(conn, "user_mgt.html", system_users: system_users, list_drivers: list_drivers)
    end 

    def create_user(conn, params) do
      case Accounts.create_user(params) do
        {:ok, _} ->
          conn
          |> put_flash(:info, "New FleetHUB User Added Sccessfully :-)")
          |> redirect(to: Routes.user_path(conn, :user_mgt))

          conn

        {:error, _} ->
          conn
          |> put_flash(:error, "Failed To Add New FleetHUB User :-(")
          |> redirect(to: Routes.user_path(conn, :user_mgt))
      end
    end

    def edit_user(conn, %{"id" => id}) do
      system_users = Accounts.get_user!(id)
      changeset = Accounts.change_user(system_users)
      render(conn, "edit_user.html", system_users: system_users, changeset: changeset)
    end

    def update_user(conn, %{"id" => id} = params) do
      system_user = Accounts.get_user!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:system_user, User.changeset(system_user, params))
      |> Ecto.Multi.run(:userlogs, fn %{system_user: system_user} ->
        activity = "FleetHUB user updated with ID \"#{system_user.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{system_user: system_user, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "FleetHUB system user updated successfully :-) ")
          |> redirect(to: Routes.user_path(conn, :user_mgt))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = UserController.traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.user_path(conn, :user_mgt))
      end
    end

    def delete_user(conn, %{"id" => id}) do
      system_user = Accounts.get_user!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.delete(:system_user, system_user)
      |> Ecto.Multi.run(:userlogs, fn %{system_user: system_user} ->
        activity = "FleetHUB system user deleted with ID \"#{system_user.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{system_user: system_user, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "FleetHUB system user deleted successfully :-) ")
          |> redirect(to: Routes.user_path(conn, :user_mgt))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = UserController.traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.user_path(conn, :user_mgt))
      end
    end

    def deactivate_user(conn, %{"id" => id}) do
      list_drivers  = Drivers.list_tbl_drivers()
      system_users = Accounts.get_user!(id)
      changeset = Accounts.change_user(system_users)
      render(conn, "deactivate.html", system_users: system_users, changeset: changeset)
    end 

    def deactivate_user_account(conn, %{"id" => id} = params) do
      system_user = Accounts.get_user!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:system_user, User.changeset(system_user, params))
      |> Ecto.Multi.run(:userlogs, fn %{system_user: system_user} ->
        activity = "FleetHUB user account deactivated with ID \"#{system_user.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{system_user: system_user, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "FleetHUB system user account deactivated :-) ")
          |> redirect(to: Routes.user_path(conn, :user_mgt))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = UserController.traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.user_path(conn, :user_mgt))
      end
    end
    
  end
  