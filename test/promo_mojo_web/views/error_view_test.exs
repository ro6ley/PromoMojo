defmodule PromoMojoWeb.ErrorViewTest do
  use PromoMojoWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(PromoMojoWeb.ErrorView, "404.json", []) == %{errors: %{detail: "Promocode not found."}, code: 404}
  end

  test "renders 500.json" do
    assert render(PromoMojoWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}, code: 500}
  end
end
