defmodule FleetWeb.DriverController do
    use FleetWeb, :controller
    alias Fleet.Clients
    alias Fleet.Vehicles
    alias Fleet.Drivers
    alias Fleet.Accounts
    alias Fleet.Accounts.User
    alias Fleet.Drivers.IssueLoger
    alias Fleet.Vehicles.VehicleDetails
    alias Fleet.{Logs.UserLogs, Repo}
    alias Fleet.License
    alias Fleet.License.Drivers_license

    plug(
      FleetWeb.Plugs.RequireAuth
    when action in [
           :list_drivers,
           :view_driver,
           :create_driver,
           :update_driver,
           :delete_driver,
           :assign_vehicle,
           :logged_issues,
           :create_issue,
           :file_issue_report,
           :request_response,
           :deactivate_driver_account
         ]
  )

    def view_driver(conn, %{"id" => id} = params) do
      list_drivers  = Accounts.get_user!(id)
      # list_vehicles = Vehicles.list_tbl_vehicles()
      render(conn, "view_driver.html", list_drivers: list_drivers) #, list_vehicles: list_vehicles
    end

    def create_driver(conn, params) do
        case Accounts.create_user(params) do
            {:ok, _} ->
              conn
              |> put_flash(:info, "New Driver Added To System")
              |> redirect(to: Routes.driver_path(conn, :list_drivers))

              conn

            {:error, whatsapp} ->
              IO.inspect "================="
              IO.inspect whatsapp
              conn
              |> put_flash(:error, :error)
              |> redirect(to: Routes.driver_path(conn, :list_drivers))
        end
    end

    def update_driver(conn, %{"id" => id} = params) do
      driver = Accounts.get_user!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:driver, User.changeset(driver, params))
      |> Ecto.Multi.run(:userlogs, fn %{driver: driver} ->
        activity = "FleetHUB driver updated with ID \"#{driver.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{driver: driver, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "Driver details successfully updated:-) ")
          |> redirect(to: Routes.driver_path(conn, :list_drivers))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = DriverController.traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.driver_path(conn, :list_drivers))
      end
    end

    def delete_driver(conn, %{"id" => id}) do
        driver = Drivers.get_driver_details!(id)

        Ecto.Multi.new()
        |> Ecto.Multi.delete(:driver, driver)
        |> Ecto.Multi.run(:userlogs, fn %{driver: driver} ->
          activity = "Deleted Driver with ID \"#{driver.id}\""

          userlogs = %{
            user_id: conn.assigns.user.id,
            activity: activity
          }

          UserLogs.changeset(%UserLogs{}, userlogs)
          |> Repo.insert()
        end)
        |> Repo.transaction()
        |> case do
          {:ok, %{driver: driver, userlogs: _userlogs}} ->
            conn
            |> put_flash(:info, "Driver deleted from system.")
            |> redirect(to: Routes.driver_path(conn, :list_drivers))

          {:error, _failed_operation, failed_value, _changes_so_far} ->
            reason = DriverController.traverse_errors(failed_value.errors) |> List.first()

            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.driver_path(conn, :list_drivers))
        end
    end

    def assign_vehicle(conn, %{"id" => id}) do
      drivers = Drivers.get_driver_details!(id)
      changeset = Drivers.change_driver_details(drivers)
      render(conn, "assign_vehicle.html", drivers: drivers, changeset: changeset)
    end

    def logged_issues(conn, _params) do
      list_issues = Drivers.list_tbl_vehicle_issue()
      render(conn, "logged_issues.html", list_issues: list_issues)
    end

    def create_issue(conn, issues) do
      case Drivers.create_issue_loger(Map.put(issues, "driver_id", conn.assigns.user.id)) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "Problem with car reported.")
            |> redirect(to: Routes.user_path(conn, :dashboard))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed to report problem with vehicle.")
            |> redirect(to: Routes.user_path(conn, :dashboard))
      end
    end



    # def user_actitvity(conn, %{"id" => user_id}) do
    #   with :error <- confirm_token(conn, user_id) do
    #     conn
    #     |> put_flash(:error, "invalid token received")
    #     |> redirect(to: Routes.user_path(conn, :list_users))
    #   else
    #     {:ok, user} ->
    #       user_logs = Logs.get_user_logs_by(user.id)
    #       page = %{first: "Users", last: "Activity logs"}
    #       render(conn, "activity_logs.html", user_logs: user_logs, page: page)
    #   end
    # end
    def file_issue_report(conn, %{"id" => id} = params) do
      issue = Drivers.get_issue_loger!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:issue, IssueLoger.changeset(issue, params))
      |> Ecto.Multi.run(:userlogs, fn %{issue: issue} ->
        activity = "vehicle problem reported with ID \"#{issue.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{issue: issue, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "Report Submitted:-) ")
          |> redirect(to: Routes.user_path(conn, :dashboard))


          conn
          |> put_flash(:error, "Failed to submit report")
          |> redirect(to: Routes.user_path(conn, :dashboard))
      end
    end

    def request_response(conn, _params) do
      responses = Drivers.list_tbl_vehicle_issue()
      vendors = Clients.list_tbl_vendors()
      render(conn, "request_response.html", responses: responses, vendors: vendors)
    end

    def rejected_request(conn, _params) do
      rejected = Drivers.list_tbl_vehicle_issue()
      render(conn, "rejected_request.html", rejected: rejected)
    end

    def deactivate_driver_account(conn, %{"id" => id} = params) do
      list_driver = Accounts.get_user!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:list_driver, User.changeset(list_driver, params))
      |> Ecto.Multi.run(:userlogs, fn %{list_driver: list_driver} ->
        activity = "FleetHUB driver account deactivated with ID \"#{list_driver.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{list_driver: list_driver, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "FleetHUB system driver account deactivated :-) ")
          |> redirect(to: Routes.driver_path(conn, :list_drivers))

        {:error, failed_operation, failed_value, changes_so_far} ->
          reason = DriverController.traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.driver_path(conn, :list_drivers))
      end
    end
end
