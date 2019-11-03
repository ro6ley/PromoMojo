defmodule PromoMojoWeb.ErrorView do
  use PromoMojoWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal Server Error"}, code: 500}
  end

  def render("404.json", _assigns) do
    %{errors: %{detail: "Promocode not found."}, code: 404}
  end

end
