defmodule FleetWeb.AdminController do
    use FleetWeb, :controller

    alias Fleet.Drivers
    alias Fleet.Clients
    alias Fleet.Vehicles
    alias Fleet.Clients.Contacts
    alias Fleet.Drivers.IssueLoger
    alias Fleet.{Logs.UserLogs, Repo}

    def list_vendors(conn, _params) do
        vendors = Clients.list_tbl_vendors()
        render(conn, "list_vendors.html", vendors: vendors)
    end

    def create_vendor(conn, params) do
        case Clients.create_contacts(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "New Vendor Added To System")
            |> redirect(to: Routes.admin_path(conn, :list_vendors))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add New Vendor To system.")
            |> redirect(to: Routes.admin_path(conn, :list_vendors))
        end
    end

    def edit_vendor(conn, %{"id" => id}) do
        vendor = Clients.get_contacts!(id)
        changeset = Clients.change_contacts(vendor)
        render(conn, "edit_vendor.html", vendor: vendor, changeset: changeset)
    end

    def update_vendor(conn, %{"id" => id} = params) do
        contact = Clients.get_contacts!(id)

        Ecto.Multi.new()
        |> Ecto.Multi.update(:contact, Contacts.changeset(contact, params))
        |> Ecto.Multi.run(:userlogs, fn %{contact: contact} ->
          activity = "Contact updated with ID \"#{contact.id}\""

          userlogs = %{
            user_id: conn.assigns.user.id,
            activity: activity
          }

          UserLogs.changeset(%UserLogs{}, userlogs)
          |> Repo.insert()
        end)
        |> Repo.transaction()
        |> case do
          {:ok, %{contact: contact, userlogs: _userlogs}} ->
            conn
            |> put_flash(:info, "Contact updated successfully.")
            |> redirect(to: Routes.admin_path(conn, :list_vendors))

          {:error, _failed_operation, failed_value, _changes_so_far} ->
            reason = AdminController.traverse_errors(failed_value.errors) |> List.first()

            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.admin_path(conn, :list_vendors))
        end
    end

    def delete_vendor(conn, %{"id" => id}) do
        vendor = Clients.get_contacts!(id)

        Ecto.Multi.new()
        |> Ecto.Multi.delete(:vendor, vendor)
        |> Ecto.Multi.run(:userlogs, fn %{vendor: vendor} ->
          activity = "Deleted Vendor with ID \"#{vendor.id}\""

          userlogs = %{
            user_id: conn.assigns.user.id,
            activity: activity
          }

          UserLogs.changeset(%UserLogs{}, userlogs)
          |> Repo.insert()
        end)
        |> Repo.transaction()
        |> case do
          {:ok, %{vendor: vendor, userlogs: _userlogs}} ->
            conn
            |> put_flash(:info, "Vendor contact deleted successfully.")
            |> redirect(to: Routes.admin_path(conn, :list_vendors))

          {:error, _failed_operation, failed_value, _changes_so_far} ->
            reason = AdminController.traverse_errors(failed_value.errors) |> List.first()

            conn
            |> put_flash(:error, reason)
            |> redirect(to: Routes.admin_path(conn, :list_vendors))
        end
    end

    def fleet_tracking(conn, _params) do
      render(conn, "fleet_tracking.html")
    end

    def inbox(conn, _params) do
      list_issues = Drivers.list_tbl_vehicle_issue()
      render(conn, "inbox.html", list_issues: list_issues)
    end

    def resolved(conn, _params) do
      list_issues = Drivers.list_tbl_vehicle_issue()
      render(conn, "resolved.html", list_issues: list_issues)
    end

    def rejected(conn, _params) do
      list_issues = Drivers.list_tbl_vehicle_issue()
      render(conn, "rejected.html", list_issues: list_issues)
    end

    def approve_request(conn, %{"id" => id} = params) do
      approve = Drivers.get_issue_loger!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:approve, IssueLoger.changeset(approve, params))
      |> Ecto.Multi.run(:userlogs, fn %{approve: approve} ->
        activity = "Vehicle Fix Approved with ID \"#{approve.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{approve: approve, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "Request Approved!")
          |> redirect(to: Routes.admin_path(conn, :inbox))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = AdminController.traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.admin_path(conn, :inbox))
      end
    end

    def reject_request(conn, %{"id" => id} = params) do
      reject = Drivers.get_issue_loger!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:reject, IssueLoger.changeset(reject, params))
      |> Ecto.Multi.run(:userlogs, fn %{reject: reject} ->
        activity = "Vehicle Fix Rejected with ID \"#{reject.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{reject: reject, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "Request Denied!")
          |> redirect(to: Routes.admin_path(conn, :inbox))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = AdminController.traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.admin_path(conn, :inbox))
      end
    end

end