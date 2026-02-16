defmodule LinguoWeb.FakeJSON do
  use LinguoWeb, :json

  def show(_) do
    %{message: "ok"}
  end
end
