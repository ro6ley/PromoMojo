# PromoMojo
PromoMojo handles your Promos for you, focus on the fun!

# Features

- [x] Generation of new promo codes for events
- [x] The promo code is worth a specific amount of ride
- [x] The promo code can expire
- [x] Can be deactivated
- [x] Return active promo codes
- [x] Return all promo codes
- [x] The promo code radius should be configurable
- [ ] Redeeming promocodes by providing the origin, destination and code 

# NB

- API currently has no auth implemented, meaning anyone can create, and manage promocodes

# Starting

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Update database config on `config/dev.exs`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Active Promocodes
To fetch all active promocodes navigate to http://localhost:4000/api/promocodes/active

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
