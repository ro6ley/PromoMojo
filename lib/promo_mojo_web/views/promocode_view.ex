defmodule PromoMojoWeb.PromocodeView do
  use PromoMojoWeb, :view
  alias PromoMojoWeb.PromocodeView

  def render("index.json", %{promocodes: promocodes}) do
    %{data: render_many(promocodes, PromocodeView, "promocode.json")}
  end

  def render("show.json", %{promocode: promocode}) do
    %{data: render_one(promocode, PromocodeView, "promocode.json")}
  end

  def render("redeem.json", %{res_data: res_data, code: code}) do
    %{data: res_data, code: code}
  end

  def render("promocode.json", %{promocode: promocode}) do
    %{id: promocode.id,
      code: promocode.code,
      value: promocode.value,
      radius: promocode.radius,
      radius_unit: promocode.radius_unit,
      is_active: promocode.is_active,
      expiry: promocode.expiry,
      location: promocode.location}
  end
end
