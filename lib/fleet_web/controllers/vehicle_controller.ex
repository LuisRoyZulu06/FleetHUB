defmodule FleetWeb.VehicleController do
    use FleetWeb, :controller
    alias Fleet.Accounts
    alias Fleet.Accounts.User
    alias Fleet.Vehicles
    alias Fleet.Vehicles.VehicleDetails
    alias Fleet.{Logs.UserLogs, Repo}

    plug(
      FleetWeb.Plugs.RequireAuth
    when action in [
           :list_vehicles,
           :create_vehicle,
           :maintain_vehicle,
           :reassign_vehicle
         ]
  )

    def list_vehicles(conn, _params) do
        list_vehicles = Vehicles.list_tbl_vehicles()
        drivers=Accounts.list_tbl_users()
        driver_ids= for driver <- list_vehicles, into: [] do driver.driver_id end
        IO.inspect "=========================================================================================="
        IO.inspect driver_ids
        [%{""=>garage}] = Vehicles.vehicles_in_maintenance()
        [%{""=>count_vehicles}] = Vehicles.vehicles_assigned()
        [%{""=>total_vehicles}] = Vehicles.total_vehicles()
        [%{""=>vehicles_unassigned}] = Vehicles.vehicles_unassigned()
        render(conn, "list_vehicles.html", list_vehicles: list_vehicles, drivers: drivers, count_vehicles: count_vehicles, total_vehicles: total_vehicles, vehicles_unassigned: vehicles_unassigned, driver_ids: driver_ids, garage: garage)
    end

    def create_vehicle(conn, params) do
     IO.inspect params
        case Vehicles.create_vehicle_details(params) do
            {:ok, _} ->
              conn
              |> put_flash(:info, "New Vehicle Added To System")
              |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
  
              conn
  
            {:error, err} ->
              IO.inspect "err is"
              IO.inspect err
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
            |> put_flash(:info, "Vehicle details updated")
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))

            {:error, %{vehicle: vehicle, userlogs: _userlogs}} ->
              conn
              |> put_flash(:error, "Failedd to update vehicle details.")
              |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))  
            # {:error, _failed_operation, failed_value, _changes_so_far} ->
            #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()
  
            # conn
            # |> put_flash(:error, reason)
            # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
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
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
  
          {:error, _failed_operation, failed_value, _changes_so_far} ->
            IO.inspect "==============================================================================================================="
            IO.inspect failed_value
            reason =VehicleController.traverse_errors(failed_value.errors) |> List.first()
  
            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
        end
    end
end