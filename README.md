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
- [x] Redeeming promocodes by providing the origin, destination and code 

## Accessing the Features

### Generate a New Promocode

Endpoint: `http://localhost:4000/api/promocodes`

HTTP Method: **POST**

Request Payload:
```
{
	"promocode": {
		"code": "MyC0DE4",
		"expiry": "2019-12-18 06:08:59.876000Z",
		"is_active": "true",
		"location": "The+Alchemist",
		"radius": 12.0,
		"radius_unit": "kilometers",
		"value": 500
		}
}
```

Sample Response:
```
{
  "data": {
    "code": "MyC0DE4",
    "expiry": "2019-12-18T06:08:59",
    "id": "7c7575e2-140d-4d63-9c66-56618727dba8",
    "is_active": true,
    "location": "The+Alchemist",
    "radius": 12.0,
    "radius_unit": "kilometers",
    "value": 500
  }
}
```

### Deactivate a Promocode

Endpoint: `http://localhost:4000/api/promocodes/<promocode_id>`

HTTP Method: **POST**

Request Payload:
```
{
	"promocode": {
		"is_active": "false"
	}
}
```

Sample Response:
```
{
  "data": {
    "code": "MyC0DE4",
    "expiry": "2019-12-18T06:08:59",
    "id": "7c7575e2-140d-4d63-9c66-56618727dba8",
    "is_active": false,
    "location": "The+Alchemist",
    "radius": 12.0,
    "radius_unit": "kilometers",
    "value": 500
  }
}
```


### Fetch All Promocodes

Endpoint: `http://localhost:4000/api/promocodes`

HTTP Method: **GET**

Sample response:
```
{
  "data": [
    {
      "code": "MyC0DE",
      "expiry": "2019-12-18T06:08:59",
      "id": "9788b2d4-ff1d-4635-88b0-2dd463203423",
      "is_active": true,
      "location": "The+Alchemist,
      "radius": 12.0,
      "radius_unit": "kilometers",
      "value": 500
    },
    ...more codes
  ]
}
```

### Fectch Active Promocodes

Endpoint: `http://localhost:4000/api/promocodes/active`

HTTP Method: **GET**

Sample response:
```
{
  "data": [
    {
      "code": "MyC0DE",
      "expiry": "2019-12-18T06:08:59",
      "id": "9788b2d4-ff1d-4635-88b0-2dd463203423",
      "is_active": true,
      "location": "The+Alchemist",
      "radius": 12.0,
      "radius_unit": "kilometers",
      "value": 500
    },
    ... more active codes
  ]
}
```

### Redeeming a Promocode

Endpoint: `http://localhost:4000/api/redeem`

HTTP Method: **POST**

Request Payload:
```
{
	"data": {
		"origin": "TRM+-+Thika+Road+Mall",
		"destination": "KCA+University",
		"promocode": "MyC0DE4"
	}
}
```

Success response with polyline data:
```
{
    "code": 200,
    "data": {
        "promo_details": {
            "expiry": "2019-12-18T06:08:59",
            "location": "TRM+-+Thika+Road+Mall",
            "radius": 12.0,
            "radius_unit": "kilometers",
            "value": 500
        },
        "polyline": "zjmF_`d`FCAGA?OA?A?CAACCEAGDMDCBAFc@?KQg@iBaBa@_@E?G?IASGWWGYD[FOJK\\KN?RDLHJLFZBRDN^d@zBnBdExDPTLVbExDlCnC`FdGzFtIbHtK~GlKvChE|N`SnFfHbFzGdB|BjBrBzApAbAt@hCtAbE~AnGvBtLvDhExAfCjAzAdAnEdErMdMxCvCtClCjKrJ~DtDtAx@jEbEjCfCv@w@pAqARSGICKEWOiACCGAGBKFKBO@EI"
    }
}
```

Error Response:
```
{
    "code": 400,
    "data": {
        "error": "Invalid location"
    }
}
```

# NB

> API currently has no auth implemented, meaning anyone can create, and manage promocodes without having
to log in.

# Starting the server

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Update database config on `config/dev.exs`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
