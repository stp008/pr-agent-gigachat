# PR-Agent Setup for Russian Environment

This repository contains a setup script for installing and configuring PR-Agent with GigaChat in Russian corporate environments, including proper certificate handling for Минцифры and Сбер.

## Quick Start

### 1. Download and Run Setup Script

```bash
# Download the setup script
wget https://raw.githubusercontent.com/stp008/pr-agent-gigachat/main/setup_pr_agent_russia.sh

# Make it executable
chmod +x setup_pr_agent_russia.sh

# Run as root (required for certificate installation)
sudo ./setup_pr_agent_russia.sh
```

### 2. Configure Your Environment

After installation, configure your Bitbucket Server credentials:

```bash
# Set your Bitbucket Server token
export BITBUCKET_SERVER__BEARER_TOKEN="your_bitbucket_token_here"

# Set your Bitbucket Server URL
export BITBUCKET_SERVER__URL="http://your-bitbucket-server:7990"
```

### 3. Start GigaChat Proxy

```bash
# Start as a service (recommended)
sudo systemctl start litellm-gigachat
sudo systemctl status litellm-gigachat

# Or start manually
start-gigachat-proxy
```

### 4. Use PR-Agent

```bash
# Basic commands
pr-agent-cli --pr_url=http://your-bitbucket-server:7990/projects/PROJ/repos/repo/pull-requests/123 describe
pr-agent-cli --pr_url=http://your-bitbucket-server:7990/projects/PROJ/repos/repo/pull-requests/123 review
pr-agent-cli --pr_url=http://your-bitbucket-server:7990/projects/PROJ/repos/repo/pull-requests/123 improve

# View all examples
pr-agent-examples
```

## What the Setup Script Does

### 1. Certificate Installation
- Downloads and installs Russian Trusted Root CA certificates from Минцифры
- Installs certificates to system certificate store
- Updates Python certificate bundle for proper HTTPS verification
- Configures SSL/TLS environment variables

### 2. Software Installation
- Installs system dependencies (Python, Git, curl, etc.)
- Clones and installs PR-Agent from GitHub
- Clones and installs litellm-gigachat proxy
- Installs all Python dependencies

### 3. Configuration Setup
- Creates configuration files for PR-Agent
- Sets up environment variables for Russian environment
- Configures GigaChat model settings

### 4. Service Creation
- Creates systemd service for litellm-gigachat proxy
- Creates wrapper scripts for easy command execution
- Sets up automatic startup and restart policies

### 5. Utility Scripts
- `pr-agent-cli`: Main CLI wrapper with proper environment
- `start-gigachat-proxy`: Manual proxy startup script
- `pr-agent-examples`: Usage examples and help

## Manual Configuration

### Edit Configuration File

```bash
sudo nano /opt/pr-agent-gigachat/pr_agent/settings/.secrets.toml
```

Example configuration:
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
url = "http://your-bitbucket-server:7990"
```

### Environment Variables

For persistent configuration, add to your shell profile:

```bash
# Add to ~/.bashrc or ~/.profile
export BITBUCKET_SERVER__BEARER_TOKEN="your_token"
export BITBUCKET_SERVER__URL="http://your-bitbucket-server:7990"
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
```

## Usage Examples

### Basic Commands

```bash
# Generate PR description
pr-agent-cli --pr_url=<bitbucket_pr_url> describe

# Perform code review
pr-agent-cli --pr_url=<bitbucket_pr_url> review

# Get improvement suggestions
pr-agent-cli --pr_url=<bitbucket_pr_url> improve

# Ask questions about the PR
pr-agent-cli --pr_url=<bitbucket_pr_url> ask "What is the main purpose of this PR?"
```

### Advanced Examples

```bash
# Security-focused review
pr-agent-cli --pr_url=<url> review \
  --pr_reviewer.require_security_review=true \
  --pr_reviewer.num_max_findings=10 \
  --pr_reviewer.extra_instructions="Focus on security vulnerabilities"

# Generate commitable code suggestions
pr-agent-cli --pr_url=<url> improve \
  --pr_code_suggestions.commitable_code_suggestions=true \
  --pr_code_suggestions.suggestions_score_threshold=7

# Custom description with AI title and diagram
pr-agent-cli --pr_url=<url> describe \
  --pr_description.generate_ai_title=true \
  --pr_description.enable_pr_diagram=true \
  --pr_description.extra_instructions="Focus on business impact"
```

### Batch Processing

```bash
#!/bin/bash
# Process multiple PRs
BASE_URL="http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests"
PR_IDS=(123 124 125)

for PR_ID in "${PR_IDS[@]}"; do
    echo "Processing PR $PR_ID..."
    pr-agent-cli --pr_url="$BASE_URL/$PR_ID" describe
    pr-agent-cli --pr_url="$BASE_URL/$PR_ID" review
done
```

## Service Management

### GigaChat Proxy Service

```bash
# Start service
sudo systemctl start litellm-gigachat

# Stop service
sudo systemctl stop litellm-gigachat

# Check status
sudo systemctl status litellm-gigachat

# View logs
journalctl -u litellm-gigachat -f

# Enable auto-start
sudo systemctl enable litellm-gigachat
```

### Manual Proxy Management

```bash
# Start manually
start-gigachat-proxy

# Check if running
curl http://localhost:4000/health

# Kill if needed
pkill -f "python3 main.py"
```

## Troubleshooting

### Common Issues

**1. Certificate Errors**
```bash
# Check certificate installation
ls -la /etc/ssl/certs/ | grep russian

# Verify Python certificates
python3 -c "import ssl; print(ssl.get_default_verify_paths())"

# Test HTTPS connection
curl -v https://api.sberbank.ru/
```

**2. GigaChat Proxy Issues**
```bash
# Check if proxy is running
curl http://localhost:4000/health

# Check proxy logs
journalctl -u litellm-gigachat -n 50

# Restart proxy
sudo systemctl restart litellm-gigachat
```

**3. Bitbucket Connection Issues**
```bash
# Test Bitbucket connectivity
curl -H "Authorization: Bearer $BITBUCKET_SERVER__BEARER_TOKEN" \
     "$BITBUCKET_SERVER__URL/rest/api/1.0/projects"

# Check token permissions
echo $BITBUCKET_SERVER__BEARER_TOKEN
```

**4. Permission Issues**
```bash
# Check file permissions
ls -la /opt/pr-agent-gigachat/
ls -la /usr/local/bin/pr-agent-cli

# Fix permissions if needed
sudo chown -R root:root /opt/pr-agent-gigachat/
sudo chmod +x /usr/local/bin/pr-agent-cli
```

### Debug Mode

Enable verbose logging:

```bash
# Set debug environment
export LOG_LEVEL="DEBUG"
export CONFIG__VERBOSITY_LEVEL=2

# Run with debug output
pr-agent-cli --pr_url=<url> describe
```

### Local Testing

Test without publishing to Bitbucket:

```bash
# Test locally without publishing
export CONFIG__PUBLISH_OUTPUT=false
pr-agent-cli --pr_url=<url> describe
```

## Security Considerations

### Certificate Management
- Certificates are installed system-wide in `/etc/ssl/certs/`
- Python certificate bundle is updated to include Russian CAs
- SSL verification is enforced for all HTTPS connections

### Token Security
- Store Bitbucket tokens in environment variables, not in files
- Use Personal Access Tokens with minimal required permissions
- Rotate tokens regularly

### Network Security
- GigaChat proxy runs on localhost:4000 by default
- Configure firewall rules if needed
- Use HTTPS for all external connections

## File Locations

### Installation Directories
- PR-Agent: `/opt/pr-agent-gigachat/`
- GigaChat Proxy: `/opt/litellm-gigachat/`
- Configuration: `/opt/pr-agent-gigachat/pr_agent/settings/.secrets.toml`

### Executable Scripts
- Main CLI: `/usr/local/bin/pr-agent-cli`
- Proxy starter: `/usr/local/bin/start-gigachat-proxy`
- Examples: `/usr/local/bin/pr-agent-examples`

### System Services
- Service file: `/etc/systemd/system/litellm-gigachat.service`
- Logs: `journalctl -u litellm-gigachat`

### Certificates
- System store: `/etc/ssl/certs/`
- Python bundle: `$(python3 -m certifi)`

## Updating

### Update PR-Agent
```bash
cd /opt/pr-agent-gigachat
sudo git pull
sudo pip3 install -r requirements.txt
```

### Update GigaChat Proxy
```bash
cd /opt/litellm-gigachat
sudo git pull
sudo pip3 install -r requirements.txt
sudo systemctl restart litellm-gigachat
```

### Update Certificates
```bash
# Re-run certificate installation part
sudo ./setup_pr_agent_russia.sh
```

## Support

For issues and questions:
1. Check the troubleshooting section above
2. Review logs: `journalctl -u litellm-gigachat -f`
3. Test individual components separately
4. Verify network connectivity and certificates

## License

This setup script and documentation are provided as-is for use in Russian corporate environments. Please ensure compliance with your organization's security policies.
