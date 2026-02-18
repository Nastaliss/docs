# Installation on Scalingo

Docs can be deployed on [Scalingo](https://scalingo.com/) using the [La Suite buildpack](https://github.com/suitenumerique/buildpack).

## Requirements

- A [Scalingo account](https://auth.scalingo.com/users/sign_up)
- A PostgreSQL database — available as a [Scalingo add-on](https://doc.scalingo.com/databases/postgresql/start)
- A Redis database — available as a [Scalingo add-on](https://doc.scalingo.com/databases/redis/start)
- An Identity Provider that supports OpenID Connect protocol (e.g. Keycloak, Zitadel)
- An Object Storage that implements S3 API (e.g. AWS S3, Scaleway Object Storage, MinIO)

## Step 1: Create your application

Create a new application on [Scalingo Dashboard](https://dashboard.scalingo.com/) and provision the PostgreSQL and Redis add-ons.

The `DATABASE_URL` and `REDIS_URL` environment variables will be automatically set by the add-ons.

## Step 2: Configure environment variables

Set the following environment variables on your Scalingo application via the dashboard or the CLI:

```bash
scalingo -a your-app-name env-set KEY=value
```

> [!NOTE]
> If your application is hosted on the SecNumCloud region, you need to specify the region on every CLI call with `--region osc-secnum-fr1`, or set it globally with `scalingo config --set default_region=osc-secnum-fr1`.

### Build configuration

| Variable | Description | Value |
|---|---|---|
| `BUILDPACK_URL` | URL of the La Suite buildpack | `https://github.com/suitenumerique/buildpack#main` |
| `LASUITE_BACKEND_DIR` | Backend directory | `.` |
| `LASUITE_NGINX_DIR` | Nginx config directory | `./` |
| `LASUITE_SCRIPT_POSTCOMPILE` | Post-compile script | `bin/buildpack_postcompile.sh` |
| `LASUITE_SCRIPT_POSTFRONTEND` | Post-frontend script | `bin/buildpack_postfrontend.sh` |

### Django / Backend

| Variable | Description | Value |
|---|---|---|
| `DJANGO_ALLOWED_HOSTS` | Hostname of your instance | `your-app-name.your-region.scalingo.io` |
| `DJANGO_CONFIGURATION` | Django configuration class | `Production` |
| `DJANGO_SECRET_KEY` | A random secret key | (generate a secure value) |
| `DJANGO_SETTINGS_MODULE` | Django settings module | `impress.settings` |
| `DJANGO_STATIC_ROOT` | Static files root | `/app/static_app/` |
| `DATA_DIR` | Data directory | `/app/data` |

### OIDC Authentication

| Variable | Description | Value |
|---|---|---|
| `OIDC_OP_AUTHORIZATION_ENDPOINT` | OIDC authorization endpoint | (from your provider) |
| `OIDC_OP_TOKEN_ENDPOINT` | OIDC token endpoint | (from your provider) |
| `OIDC_OP_JWKS_ENDPOINT` | OIDC JWKS endpoint | (from your provider) |
| `OIDC_OP_USER_ENDPOINT` | OIDC userinfo endpoint | (from your provider) |
| `OIDC_RP_CLIENT_ID` | OIDC client ID | (from your provider) |
| `OIDC_RP_CLIENT_SECRET` | OIDC client secret | (from your provider) |
| `LOGIN_REDIRECT_URL` | Redirect URL after login | `/` |
| `LOGIN_REDIRECT_URL_FAILURE` | Redirect URL after failed login | `/` |
| `LOGOUT_REDIRECT_URL` | Redirect URL after logout | `/` |

### S3 Object Storage

| Variable | Description | Value |
|---|---|---|
| `AWS_S3_ENDPOINT_URL` | S3 endpoint URL | (from your provider) |
| `AWS_S3_ACCESS_KEY_ID` | S3 access key | (from your provider) |
| `AWS_S3_SECRET_ACCESS_KEY` | S3 secret key | (from your provider) |
| `AWS_S3_REGION_NAME` | S3 region | (from your provider) |
| `AWS_STORAGE_BUCKET_NAME` | S3 bucket name | `docs-media-storage` |
| `MEDIA_BASE_URL` | Public URL for media | `https://your-app-name.your-region.scalingo.io` |

### Collaboration server

| Variable | Description | Value |
|---|---|---|
| `COLLABORATION_API_URL` | Y-provider API URL | `http://localhost:4444/` |
| `COLLABORATION_SERVER_SECRET` | Shared secret for the collaboration server | (generate a secure value) |
| `Y_PROVIDER_API_BASE_URL` | Y-provider API base URL | `http://localhost:4444/api/` |
| `Y_PROVIDER_API_KEY` | Y-provider API key | (generate a secure value) |

### Frontend

| Variable | Description | Value |
|---|---|---|
| `FRONTEND_THEME` | Frontend theme | `default` |
| `NEXT_PUBLIC_SW_DEACTIVATED` | Deactivate service worker | `true` |

## Step 3: Deploy

Link your Scalingo app to the Docs repository and deploy:

```bash
# Install the Scalingo CLI if needed: https://doc.scalingo.com/cli
scalingo login

# Add the Scalingo git remote
git remote add scalingo git@ssh.your-region.scalingo.com:your-app-name.git

# Deploy
git push scalingo main
```

The La Suite buildpack will automatically build the frontend, install Python dependencies, and configure Nginx.

## Step 4: Post-deployment

Run the database migration and create an admin user:

```bash
scalingo -a your-app-name run python manage.py migrate
scalingo -a your-app-name run python manage.py createsuperuser --email admin@example.com --password your-secure-password
```

Your Docs instance is now available at `https://your-app-name.your-region.scalingo.io`.

The admin interface is available at `https://your-app-name.your-region.scalingo.io/admin`.

## Useful links

- [Buildpack for La Suite](https://github.com/suitenumerique/buildpack) — supports Docs and other apps from La Suite
- [Scalingo documentation](https://doc.scalingo.com/)
- [The Twelve-Factor App](https://12factor.net/) — methodology behind buildpack-based deployments
