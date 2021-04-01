defmodule Fleet.Emails.Email do
  import Bamboo.Email
  alias Fleet.Emails.Mailer
  alias Fleet.Notifications.Email
  alias Fleet.Repo
  use Bamboo.Phoenix, view: FleetWeb.EmailView
  # def send_email_notification(attr) do
  #   Notifications.list_tbl_email_logs()
  #   |> Task.async_stream(&(email_alert(&1.email, attr) |> Mailer.deliver_now()),
  #     max_concurrency: 10,
  #     timeout: 30_000
  #   ) Fleet.Emails.Email.password_alert(mail,"Test")
  #   |> Stream.run()
  # end

  def password_alert(email, password) do
    password(email, password) |> Mailer.deliver_later()
  end

  def confirm_password_reset(token, email) do
    confirmation_token(token, email) |> Mailer.deliver_later()
  end

  def password(email, password) do
    new_email()
    |> from("FleetHUB")
    |> to("#{email}")
    |> put_html_layout({FleetWeb.LayoutView, "email.html"})
    |> subject("Fleet Login Credentials")
    |> assign(:password, password)
    |> render("password_content.html")
  end

  def confirmation_token(token, email) do
    new_email()
    |> from("FleetHUB")
    |> to("#{email}")
    |> put_html_layout({FleetWeb.LayoutView, "email.html"})
    |> subject("Fleet Login Credentials")
    |> assign(:token, token)
    |> render("token_content.html")
  end

  def send_alert(pwd, email, first_name) do
    sender_email = "FleetHUB"
    sender_name = "Natsave"
    subject = "Fleet Login Credentials"

    mail_body =
      "Hello #{email},\n your password to FleetHUB is: #{pwd}"

    params = %{
      subject: subject,
      sender_email: sender_email,
      sender_name: sender_name,
      mail_body: mail_body,
      recipient_email: email
    }

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:create_email, Email.changeset(%Email{}, params))
    |> Repo.transaction()
    |> case do
      {:ok, changeset} ->
        IO.inspect(changeset)

      {:error, xch} ->
        IO.inspect(xch)
    end

    # new_email()
    # |> from("natsaveepay@natsave.co.zm")
    # |> to(email)
    # |> subject("Fleet Login Credentials")
    # |> text_body("""
    #   Hello #{first_name}, \r\n you can login to our E-Tax platform using username: #{email},
    #    and password: #{pwd}.
    # """)
    # |> Mailer.deliver_later()
  end

  def forgot_pwd_confirmation(pwd, email, first_name) do
    sender_email = "natsaveepay@natsave.co.zm"
    sender_name = "Stanbic Bank"
    subject = "New Fleet Password"

    mail_body = "Hello #{email},\nYour new login password is: #{pwd}."

    params = %{
      subject: subject,
      sender_email: sender_email,
      sender_name: sender_name,
      mail_body: mail_body,
      recipient_email: email
    }

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:create_email, Email.changeset(%Email{}, params))
    |> Repo.transaction()
    |> case do
      {:ok, changeset} ->
        IO.inspect(changeset)

      {:error, xch} ->
        IO.inspect(xch)
    end
  end

  # def send_alert(pwd, email, first_name) do
  #   new_email()
  #   |> from("natsaveepay@natsave.co.zm")
  #   |> to(email)
  #   |> subject("Fleet Login Credentials")
  #   |> text_body("""
  #     Hello #{first_name}, \r\n you can login to our E-Tax platform using username: #{email},
  #      and password: #{pwd}.
  #   """)
  #   |> Mailer.deliver_later()
  # end

  def send_mail(to, subject, body) do
    sender_email = "stanbic@stanbic.co.zm"
    sender_name = "StanbicFleet"

    params = %{
      subject: subject,
      sender_email: sender_email,
      sender_name: sender_name,
      mail_body: body,
      recipient_email: to
    }

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:create_email, Email.changeset(%Email{}, params))
    |> Repo.transaction()
    |> case do
      {:ok, changeset} -> IO.inspect("Mail Submited")
      {:error, xch} -> IO.inspect("Failed to log mail")
    end
  end

  def notify_assessment_approver(email_addr, batch_ref, token) do
    new_email()
    |> from("natsaveepay@natsave.co.zm")
    |> to(email_addr)
    |> subject("Assessments for approval")
    |> text_body("""
    Dear ASCUDA World user, \r\n you have assessments with batch reference #{batch_ref} awaiting your approval\r\n.
    \r\n your approval token is #{token} \r\n.
    Regards Fleet.
    """)
    |> Mailer.deliver_later()
  end

  def notify_bill_approver(email_addr, batch_ref, token) do
    new_email()
    |> from("natsaveepay@natsave.co.zm")
    |> to(email_addr)
    |> subject("Bills for approval")
    |> text_body("""
    Dear Fleet user, \r\n you have a bill service with reference #{batch_ref} awaiting your approval\r\n.
    \r\n your approval token is #{token} \r\n.
    Regards Fleet.
    """)
    |> Mailer.deliver_later()
  end


end
