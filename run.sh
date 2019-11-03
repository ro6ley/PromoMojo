#!/bin/sh
echo "To run in production mode:"
echo "\t./run.sh --prod\n"

echo "To run in dev mode:"
echo "\t./run.sh\n"

# update this
export DATABASE_URL=ecto://USERNAME:PASSWORD@HOST:PORT/DATABASE_NAME
export SECRET_KEY_BASE=verylongandsecret
# update this
export GOOGLE_API_KEY=GOOGLE-API-KEY-WITH-DIRECTIONS-API-ENABLED

if [[ $1 == "prod" || $1 == "--prod" ]]; then
    echo "Running PromoMojo in production mode"
    MIX_ENV=prod
else
    echo "Running in dev mode"
fi

PORT=4000
mix phx.server
