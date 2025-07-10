# Setting up PR-Agent as Webhook Server for Bitbucket Server with GigaChat

This guide describes the process of setting up and running PR-Agent as a webhook server for Bitbucket Server, using the GigaChat model through litellm-gigachat.

## Prerequisites

### 1. Installing and configuring litellm-gigachat

PR-Agent uses GigaChat through the litellm-gigachat proxy server:

```bash
# Clone and install litellm-gigachat
git clone https://github.com/stp008/litellm-gigachat
cd litellm-gigachat
pip install -r requirements.txt

# Run the proxy server (default port 4000)
python main.py
```

Detailed documentation for setting up litellm-gigachat is available in the repository: https://github.com/stp008/litellm-gigachat

### 2. Installing PR-Agent dependencies

```bash
pip install -r requirements.txt
```

## Configuration

### Creating configuration file

Create or edit the file `pr_agent/settings/.secrets.toml` with the following content:

```toml
[config]
model="openai/gigachat-max"
fallback_models=["openai/gigachat-pro"]
custom_model_max_tokens=200000
git_provider="bitbucket_server"

[openai]
api_base = "http://localhost:4000"

[bitbucket_server]
bearer_token = "YOUR_BITBUCKET_BEARER_TOKEN"
webhook_secret = "YOUR_WEBHOOK_SECRET"
url = "http://your-bitbucket-server:7990"
pr_commands = [
    "/describe --pr_description.final_update_message=false",
    "/review",
    "/improve --pr_code_suggestions.commitable_code_suggestions=true",
]

[pr_reviewer]
enable_review_labels_effort = true
enable_auto_approval = true
```

### Configuration parameters

- **model**: GigaChat model to use (`openai/gigachat-max` or `openai/gigachat-pro`)
- **fallback_models**: Backup models in case the primary model is unavailable
- **custom_model_max_tokens**: Maximum number of tokens for the model
- **api_base**: URL of the litellm-gigachat proxy server (default `http://localhost:4000`)
- **bearer_token**: Bearer token for authentication with Bitbucket Server
- **webhook_secret**: Secret key for webhook request verification
- **url**: URL of your Bitbucket Server
- **pr_commands**: Commands that will be automatically executed when a PR is created

## Running the webhook server

### Basic startup method

```bash
python3 -m pr_agent.servers.bitbucket_server_webhook
```

The server will start on port 3000 by default.

### Running on a custom port

```bash
PORT=8080 python3 -m pr_agent.servers.bitbucket_server_webhook
```

### Alternative method using environment variables

Instead of a configuration file, you can use environment variables:

```bash
export CONFIG__MODEL="openai/gigachat-max"
export CONFIG__FALLBACK_MODELS='["openai/gigachat-pro"]'
export CONFIG__CUSTOM_MODEL_MAX_TOKENS=200000
export CONFIG__GIT_PROVIDER="bitbucket_server"
export OPENAI__API_BASE="http://localhost:4000"
export BITBUCKET_SERVER__BEARER_TOKEN="YOUR_BITBUCKET_BEARER_TOKEN"
export BITBUCKET_SERVER__WEBHOOK_SECRET="YOUR_WEBHOOK_SECRET"
export BITBUCKET_SERVER__URL="http://your-bitbucket-server:7990"
export PR_REVIEWER__ENABLE_REVIEW_LABELS_EFFORT=true
export PR_REVIEWER__ENABLE_AUTO_APPROVAL=true

python3 -m pr_agent.servers.bitbucket_server_webhook
```

## Bitbucket Server Configuration

### Creating a webhook in Bitbucket Server

1. Go to repository settings in Bitbucket Server
2. Select "Webhooks" from the menu
3. Click "Create webhook"
4. Fill in the fields:
   - **Name**: PR-Agent Webhook
   - **URL**: `http://your-pr-agent-server:3000/webhook`
   - **Secret**: The same secret specified in the configuration
   - **Events**: Select "Pull request opened" and "Pull request comment added"

### Setting up Bearer Token

1. Create a Personal Access Token in Bitbucket Server:
   - Go to user settings
   - Select "Personal access tokens"
   - Create a new token with permissions to read repositories and create comments
2. Use this token as `bearer_token` in the configuration

## Endpoints

After starting the server, the following endpoints are available:

- **GET** `/` - Server status check
- **POST** `/webhook` - Main endpoint for receiving webhook events from Bitbucket
- **POST** `/` - Redirect to `/webhook`

## Supported events

PR-Agent processes the following Bitbucket Server events:

- **pr:opened** - Creating a new Pull Request
  - Commands from `pr_commands` are automatically executed
- **pr:comment:added** - Adding a comment to a PR
  - Comment text is processed as a PR-Agent command

## PR-Agent commands

Available commands for use in comments:

- `/describe` - Generate PR description
- `/review` - Perform code review
- `/improve` - Code improvement suggestions
- `/ask "question"` - Ask a question about the PR
- `/help` - Command help

## Logging

To configure logging level, use the environment variable:

```bash
export LOG_LEVEL=INFO  # DEBUG, INFO, WARNING, ERROR
python3 -m pr_agent.servers.bitbucket_server_webhook
```

## Troubleshooting

### Dependency issues

If you encounter errors like `ModuleNotFoundError`, install missing dependencies:

```bash
pip install giteapy uvicorn fastapi starlette-context
```

### GigaChat connection issues

1. Make sure litellm-gigachat is running and accessible on the specified port
2. Check the correctness of the URL in `api_base`
3. Ensure you have a valid API key for GigaChat

### Bitbucket Server issues

1. Check the correctness of the Bearer Token
2. Make sure the webhook secret matches in the configuration and Bitbucket settings
3. Check the availability of the PR-Agent server from the Bitbucket Server network

## Security

- Use HTTPS for production deployment
- Regularly update the Bearer Token
- Use a complex webhook secret
- Restrict network access to the PR-Agent server

## Monitoring

For monitoring server operation, it is recommended to:

1. Set up file logging
2. Use a reverse proxy (nginx) with logging
3. Monitor the availability of the `/` endpoint for health checks
