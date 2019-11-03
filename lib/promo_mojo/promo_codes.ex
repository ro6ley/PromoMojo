defmodule PromoMojo.PromoCodes do
  @moduledoc """
  The PromoCodes context.
  """

  import Ecto.Query, warn: false
  alias PromoMojo.Repo

  alias PromoMojo.PromoCodes.Promocode

  @doc """
  Returns the list of promocodes.

  ## Examples

      iex> list_promocodes()
      [%Promocode{}, ...]

  """
  def list_promocodes do
    Repo.all(Promocode)
  end

  @doc """
  Returns the list of active promocodes.

  ## Examples

      iex> list_active_promocodes()
      [%Promocode{}, ...]

  """
  def list_active_promocodes do
    query = from(p in Promocode, where: p.is_active == ^true)
    query |> Repo.all()
  end#

  @doc """
  Gets a single promocode.

  Raises `Ecto.NoResultsError` if the Promocode does not exist.

  ## Examples

      iex> get_promocode!(123)
      %Promocode{}

      iex> get_promocode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promocode!(id), do: Repo.get!(Promocode, id)

  @doc """
  Gets a single promocode by using it's code.

  Raises `Ecto.NoResultsError` if the Promocode does not exist.

  ## Examples

      iex> get_promocode!("MYC0DE1")
      %Promocode{}

      iex> get_promocode!(MYC0DE1)
      ** (Ecto.NoResultsError)

  """
  def get_promocode_by_code!(code), do: Repo.get_by!(Promocode, code: code)

  @doc """
  Creates a promocode.

  ## Examples

      iex> create_promocode(%{field: value})
      {:ok, %Promocode{}}

      iex> create_promocode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promocode(attrs \\ %{}) do
    %Promocode{}
    |> Promocode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a promocode.

  ## Examples

      iex> update_promocode(promocode, %{field: new_value})
      {:ok, %Promocode{}}

      iex> update_promocode(promocode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promocode(%Promocode{} = promocode, attrs) do
    promocode
    |> Promocode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Promocode.

  ## Examples

      iex> delete_promocode(promocode)
      {:ok, %Promocode{}}

      iex> delete_promocode(promocode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_promocode(%Promocode{} = promocode) do
    Repo.delete(promocode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promocode changes.

  ## Examples

      iex> change_promocode(promocode)
      %Ecto.Changeset{source: %Promocode{}}

  """
  def change_promocode(%Promocode{} = promocode) do
    Promocode.changeset(promocode, %{})
  end
end
