defmodule Fleet.NotificationsTest do
  use Fleet.DataCase

  alias Fleet.Notifications

  describe "tbl_email" do
    alias Fleet.Notifications.Email

    @valid_attrs %{attempts: "some attempts", mail_body: "some mail_body", recipient_email: "some recipient_email", sender_email: "some sender_email", status: "some status", subject: "some subject"}
    @update_attrs %{attempts: "some updated attempts", mail_body: "some updated mail_body", recipient_email: "some updated recipient_email", sender_email: "some updated sender_email", status: "some updated status", subject: "some updated subject"}
    @invalid_attrs %{attempts: nil, mail_body: nil, recipient_email: nil, sender_email: nil, status: nil, subject: nil}

    def email_fixture(attrs \\ %{}) do
      {:ok, email} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Notifications.create_email()

      email
    end

    test "list_tbl_email/0 returns all tbl_email" do
      email = email_fixture()
      assert Notifications.list_tbl_email() == [email]
    end

    test "get_email!/1 returns the email with given id" do
      email = email_fixture()
      assert Notifications.get_email!(email.id) == email
    end

    test "create_email/1 with valid data creates a email" do
      assert {:ok, %Email{} = email} = Notifications.create_email(@valid_attrs)
      assert email.attempts == "some attempts"
      assert email.mail_body == "some mail_body"
      assert email.recipient_email == "some recipient_email"
      assert email.sender_email == "some sender_email"
      assert email.status == "some status"
      assert email.subject == "some subject"
    end

    test "create_email/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notifications.create_email(@invalid_attrs)
    end

    test "update_email/2 with valid data updates the email" do
      email = email_fixture()
      assert {:ok, %Email{} = email} = Notifications.update_email(email, @update_attrs)
      assert email.attempts == "some updated attempts"
      assert email.mail_body == "some updated mail_body"
      assert email.recipient_email == "some updated recipient_email"
      assert email.sender_email == "some updated sender_email"
      assert email.status == "some updated status"
      assert email.subject == "some updated subject"
    end

    test "update_email/2 with invalid data returns error changeset" do
      email = email_fixture()
      assert {:error, %Ecto.Changeset{}} = Notifications.update_email(email, @invalid_attrs)
      assert email == Notifications.get_email!(email.id)
    end

    test "delete_email/1 deletes the email" do
      email = email_fixture()
      assert {:ok, %Email{}} = Notifications.delete_email(email)
      assert_raise Ecto.NoResultsError, fn -> Notifications.get_email!(email.id) end
    end

    test "change_email/1 returns a email changeset" do
      email = email_fixture()
      assert %Ecto.Changeset{} = Notifications.change_email(email)
    end
  end

  describe "tbl_sms" do
    alias Fleet.Notifications.Sms

    @valid_attrs %{date_sent: "some date_sent", mobile: "some mobile", msg_count: "some msg_count", sms: "some sms", status: "some status", type: "some type"}
    @update_attrs %{date_sent: "some updated date_sent", mobile: "some updated mobile", msg_count: "some updated msg_count", sms: "some updated sms", status: "some updated status", type: "some updated type"}
    @invalid_attrs %{date_sent: nil, mobile: nil, msg_count: nil, sms: nil, status: nil, type: nil}

    def sms_fixture(attrs \\ %{}) do
      {:ok, sms} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Notifications.create_sms()

      sms
    end

    test "list_tbl_sms/0 returns all tbl_sms" do
      sms = sms_fixture()
      assert Notifications.list_tbl_sms() == [sms]
    end

    test "get_sms!/1 returns the sms with given id" do
      sms = sms_fixture()
      assert Notifications.get_sms!(sms.id) == sms
    end

    test "create_sms/1 with valid data creates a sms" do
      assert {:ok, %Sms{} = sms} = Notifications.create_sms(@valid_attrs)
      assert sms.date_sent == "some date_sent"
      assert sms.mobile == "some mobile"
      assert sms.msg_count == "some msg_count"
      assert sms.sms == "some sms"
      assert sms.status == "some status"
      assert sms.type == "some type"
    end

    test "create_sms/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notifications.create_sms(@invalid_attrs)
    end

    test "update_sms/2 with valid data updates the sms" do
      sms = sms_fixture()
      assert {:ok, %Sms{} = sms} = Notifications.update_sms(sms, @update_attrs)
      assert sms.date_sent == "some updated date_sent"
      assert sms.mobile == "some updated mobile"
      assert sms.msg_count == "some updated msg_count"
      assert sms.sms == "some updated sms"
      assert sms.status == "some updated status"
      assert sms.type == "some updated type"
    end

    test "update_sms/2 with invalid data returns error changeset" do
      sms = sms_fixture()
      assert {:error, %Ecto.Changeset{}} = Notifications.update_sms(sms, @invalid_attrs)
      assert sms == Notifications.get_sms!(sms.id)
    end

    test "delete_sms/1 deletes the sms" do
      sms = sms_fixture()
      assert {:ok, %Sms{}} = Notifications.delete_sms(sms)
      assert_raise Ecto.NoResultsError, fn -> Notifications.get_sms!(sms.id) end
    end

    test "change_sms/1 returns a sms changeset" do
      sms = sms_fixture()
      assert %Ecto.Changeset{} = Notifications.change_sms(sms)
    end
  end
end
