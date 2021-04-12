defmodule FleetWeb.VehicleController do
    use FleetWeb, :controller
    alias Fleet.Accounts
    alias Fleet.Accounts.User
    alias Fleet.Vehicles
    alias Fleet.Drivers
    alias Fleet.Drivers.IssueLoger
    alias Fleet.Vehicles.VehicleDetails
    alias Fleet.{Logs.UserLogs, Repo}
    alias Fleet.Problems
    alias Fleet.Problems.Vehicle_problem

    plug(
      FleetWeb.Plugs.RequireAuth
    when action in [
           :vehicle_mgt,
           :create_vehicle,
           :maintain_vehicle,
           :reassign_vehicle,
           :mgt_problem,
           :create_problem,
           :update_problem
         ]
  )

    def vehicle_mgt(conn, _params) do
        list_vehicles = Vehicles.list_tbl_vehicles()
        drivers=Accounts.list_tbl_users()
        driver_ids= for driver <- list_vehicles, into: [] do driver.driver_id end

        [%{"count"=>garage}] = Vehicles.vehicles_in_maintenance()
        [%{"count"=>count_vehicles}] = Vehicles.vehicles_assigned()
        total_vehicles = Vehicles.total_vehicles()
        [%{"count"=>vehicles_unassigned}] = Vehicles.vehicles_unassigned()
        render(conn, "index.html", list_vehicles: list_vehicles, drivers: drivers, count_vehicles: count_vehicles, total_vehicles: total_vehicles, vehicles_unassigned: vehicles_unassigned, driver_ids: driver_ids, garage: garage)
    end

    def create_vehicle(conn, params) do
     IO.inspect params
        case Vehicles.create_vehicle_details(params) do
            {:ok, _} ->
              conn
              |> put_flash(:info, "New Vehicle Added To System")
              |> redirect(to: Routes.vehicle_path(conn, :vehicle_mgt))

              conn

            {:error, err} ->
              IO.inspect "err is"
              IO.inspect err
              conn
              |> put_flash(:error, "Failed To Add New Vehicle To system.")
              |> redirect(to: Routes.vehicle_path(conn, :vehicle_mgt))
        end
    end

    def update_vehicle(conn, %{"id" => id} = params) do
        vehicle = Vehicles.get_vehicle_details!(id)

        Ecto.Multi.new()
        |> Ecto.Multi.update(:vehicle, VehicleDetails.changeset(vehicle, params))
        |> Ecto.Multi.run(:userlogs, fn _run,  %{vehicle: vehicle} ->
          activity = "FleetHUB vehicle updated with ID \"#{vehicle.id}\""

          userlogs = %{
            user_id: conn.assigns.user.id,
            activity: activity
          }

          UserLogs.changeset(%UserLogs{}, userlogs)
          |> Repo.insert()
        end)
        |> Repo.transaction()
        |> case do
          {:ok, %{vehicle: vehicle, userlogs: _userlogs}} ->
            conn
            |> put_flash(:info, "Vehicle details updated")
            |> redirect(to: Routes.vehicle_path(conn, :vehicle_mgt))

            {:error, %{vehicle: vehicle, userlogs: _userlogs}} ->
              conn
              |> put_flash(:error, "Failedd to update vehicle details.")
              |> redirect(to: Routes.vehicle_path(conn, :vehicle_mgt))
            # {:error, _failed_operation, failed_value, _changes_so_far} ->
            #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

            # conn
            # |> put_flash(:error, reason)
            # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
        end
    end

    def maintain_vehicle(conn, _params) do
        [%{"count"=>garage}] = Vehicles.vehicles_in_maintenance()
        maintenance = Drivers.list_tbl_vehicle_issue()
        render(conn, "maintain_vehicle.html", maintenance: maintenance, garage: garage)
    end

    def assign_vehicle(conn, %{"id" => id} = params) do
        vehicle = Vehicles.get_vehicle_details!(id)

        Ecto.Multi.new()
        |> Ecto.Multi.update(:vehicle, VehicleDetails.changeset(vehicle, params))
        |> Ecto.Multi.run(:userlogs, fn _run, %{vehicle: vehicle} ->
          activity = "FleetHUB vehicle updated with ID \"#{vehicle.id}\""

          userlogs = %{
            user_id: conn.assigns.user.id,
            activity: activity
          }

          UserLogs.changeset(%UserLogs{}, userlogs)
          |> Repo.insert()
        end)
        |> Repo.transaction()
        |> case do
          {:ok, %{vehicle: vehicle, userlogs: _userlogs}} ->
            conn
            |> put_flash(:info, "Vehicle Assigned To Driver:-) ")
            |> redirect(to: Routes.vehicle_path(conn, :vehicle_mgt))

          {:error, _failed_operation, failed_value, _changes_so_far} ->
            reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.vehicle_path(conn, :vehicle_mgt))
        end
    end

    def reassign_vehicle(conn, %{"id" => id, "driver_id"=> driver_id} = params) do
        vehicle = Vehicles.get_vehicle_details!(id)
        current_vehicle = Vehicles.get_by_user_id(driver_id)

        multi = case current_vehicle do
          nil->
            Ecto.Multi.new()
            |> Ecto.Multi.update(:assign, VehicleDetails.changeset(vehicle, params))
          current_vehicle->
            Ecto.Multi.new()
            |> Ecto.Multi.update(:unassign, VehicleDetails.changeset(current_vehicle, Map.merge(Map.from_struct(current_vehicle), %{driver_id: nil, assignment_status: "0"})))
            |> Ecto.Multi.update(:assign, VehicleDetails.changeset(vehicle, params))
        end

        # Ecto.Multi.new()
        # |> Ecto.Multi.update(:unassign, VehicleDetails.changeset(current_vehicle, Map.merge(Map.from_struct(current_vehicle), %{driver_id: nil, assignment_status: "0"})))
        # |> Ecto.Multi.update(:assign, VehicleDetails.changeset(vehicle, params))
        multi
        |> Ecto.Multi.run(:userlogs, fn %{assign: vehicle} ->
          activity = "FleetHUB vehicle updated with ID \"#{vehicle.id}\""

          userlogs = %{
            user_id: conn.assigns.user.id,
            activity: activity
          }

          UserLogs.changeset(%UserLogs{}, userlogs)
          |> Repo.insert()
        end)
        |> Repo.transaction()
        |> case do
          {:ok, %{assign: vehicle, userlogs: _userlogs}} ->
            conn
            |> put_flash(:info, "Vehicle Reassigned To New Driver:-) ")
            |> redirect(to: Routes.vehicle_path(conn, :vehicle_mgt))

          {:error, _failed_operation, failed_value, _changes_so_far} ->
            IO.inspect "==============================================================================================================="
            IO.inspect failed_value
            reason =VehicleController.traverse_errors(failed_value.errors) |> List.first()

            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.vehicle_path(conn, :vehicle_mgt))
        end
    end

  #  -------------------------------Problem Maintenance-------------------------------------------------
  def mgt_problem(conn, _params) do
    problems = Problems.list_tbl_vehicle_problems()
    render(conn, "vehicle_problem.html", problems: problems)
  end

  def create_problem(conn, params) do
    case Problems.create_vehicle_problem(params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "New Problem Added Sccessfully :-)")
        |> redirect(to: Routes.vehicle_path(conn, :mgt_problem))

        conn

      {:error, _} ->
        conn
        |> put_flash(:error, "Failed To Add New Problem :-(")
        |> redirect(to: Routes.vehicle_path(conn, :mgt_problem))
    end
  end

  def update_problem(conn, %{"id" => id} = params) do
    problems = Problems.get_vehicle_problem!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:problems, Vehicle_problem.changeset(problems, params))
    |> Ecto.Multi.run(:userlogs, fn %{problems: problems} ->
      activity = "FleetHUB Problem updated with ID \"#{problems.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{problems: problems, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "FleetHUB Problem updated successfully :-) ")
        |> redirect(to: Routes.vehicle_path(conn, :mgt_problem))

      {:error, _failed_operation, failed_value, _changes_so_far} ->
        reason =VehicleController.traverse_errors(failed_value.errors) |> List.first()

        conn
        |> put_flash(:error, reason)
        |> redirect(to: Routes.vehicle_path(conn, :mgt_problem))
    end
  end
end
