defmodule FleetWeb.NotificationsController do
  use FleetWeb, :controller

  alias Fleet.Notifications
  alias Fleet.Notifications.Email

  def email_logs(conn, _params) do
    email_logs = Notifications.list_email_logs()
    render(conn, "email_logs.html", email_logs: email_logs)
  end
end
