defmodule FleetWeb.VehicleController do
    use FleetWeb, :controller
    alias Fleet.Accounts
    alias Fleet.Accounts.User
    alias Fleet.Vehicles
    alias Fleet.Vehicles.VehicleDetails
    alias Fleet.{Logs.UserLogs, Repo}

    def list_vehicles(conn, _params) do
        list_drivers  = Accounts.list_tbl_users()
        list_vehicles = Vehicles.list_tbl_vehicles()
        render(conn, "list_vehicles.html", list_vehicles: list_vehicles, list_drivers: list_drivers)
    end

    def create_vehicle(conn, params) do
      user_id = conn.assigns.user
      IO.inspect "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
      IO.inspect user_id
      # params = Map.merge(%{"user_id" => user_id}, params)
        case Vehicles.create_vehicle_details(params) do
            {:ok, _} ->
              conn
              |> put_flash(:info, "New Vehicle Added To System")
              |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
  
              conn
  
            {:error, _} ->
              conn
              |> put_flash(:error, "Failed To Add New Vehicle To system.")
              |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
        end
    end

    def update_vehicle(conn, %{"id" => id} = params) do
        vehicle = Vehicles.get_vehicle_details!(id)
  
        Ecto.Multi.new()
        |> Ecto.Multi.update(:vehicle, VehicleDetails.changeset(vehicle, params))
        |> Ecto.Multi.run(:userlogs, fn %{vehicle: vehicle} ->
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
            |> put_flash(:info, "Vehicle details updated:-) ")
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
  
          {:error, _failed_operation, failed_value, _changes_so_far} ->
            reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()
  
            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
        end
    end

    def maintain_vehicle(conn, _params) do
        render(conn, "maintain_vehicle.html")
    end

    def assign_vehicle(conn, %{"id" => id} = params) do
        vehicle = Vehicles.get_vehicle_details!(id)
  
        Ecto.Multi.new()
        |> Ecto.Multi.update(:vehicle, VehicleDetails.changeset(vehicle, params))
        |> Ecto.Multi.run(:userlogs, fn %{vehicle: vehicle} ->
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
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
  
          {:error, _failed_operation, failed_value, _changes_so_far} ->
            reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()
  
            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
        end
    end

    def reassign_vehicle(conn, %{"id" => id} = params) do
        vehicle = Vehicles.get_vehicle_details!(id)
  
        Ecto.Multi.new()
        |> Ecto.Multi.update(:vehicle, VehicleDetails.changeset(vehicle, params))
        |> Ecto.Multi.run(:userlogs, fn %{vehicle: vehicle} ->
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
            |> put_flash(:info, "Vehicle Reassigned To New Driver:-) ")
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
  
          {:error, _failed_operation, failed_value, _changes_so_far} ->
            reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()
  
            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
        end
    end
end