#!/bin/bash

# PR-Agent Setup Script for Russian Environment
# This script installs Russian certificates and sets up PR-Agent with GigaChat

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root for certificate installation
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_warning "Running as root. This is required for certificate installation."
    else
        log_error "This script needs to be run as root for certificate installation."
        log_info "Please run: sudo $0"
        exit 1
    fi
}

# Install system dependencies
install_dependencies() {
    log_info "Installing system dependencies..."
    
    if command -v apt-get &> /dev/null; then
        apt-get update
        apt-get install -y curl wget ca-certificates python3 python3-pip git openssl
    elif command -v yum &> /dev/null; then
        yum update -y
        yum install -y curl wget ca-certificates python3 python3-pip git openssl
    elif command -v dnf &> /dev/null; then
        dnf update -y
        dnf install -y curl wget ca-certificates python3 python3-pip git openssl
    else
        log_error "Unsupported package manager. Please install curl, wget, ca-certificates, python3, python3-pip, git, openssl manually."
        exit 1
    fi
    
    log_success "System dependencies installed"
}

# Download and install Russian certificates
install_russian_certificates() {
    log_info "Installing Russian certificates..."
    
    # Create temporary directory for certificates
    CERT_DIR="/tmp/russian_certs"
    mkdir -p "$CERT_DIR"
    
    # Download Минцифры certificates
    log_info "Downloading Минцифры certificates..."
    
    # Russian Trusted Root CA
    curl -s -o "$CERT_DIR/russian_trusted_root_ca.crt" \
        "https://gu-st.ru/content/lending/russian_trusted_root_ca_pem.crt" || \
        log_warning "Failed to download Russian Trusted Root CA"
    
    # Russian Trusted Sub CA
    curl -s -o "$CERT_DIR/russian_trusted_sub_ca.crt" \
        "https://gu-st.ru/content/lending/russian_trusted_sub_ca_pem.crt" || \
        log_warning "Failed to download Russian Trusted Sub CA"
    
    # Download Сбер certificates
    log_info "Downloading Сбер certificates..."
    
    # Sberbank certificates (if available)
    # Note: These URLs might need to be updated based on actual Sberbank certificate distribution
    
    # Install certificates to system store
    log_info "Installing certificates to system certificate store..."
    
    if [ -d "/etc/ssl/certs" ]; then
        # Debian/Ubuntu style
        for cert in "$CERT_DIR"/*.crt; do
            if [ -f "$cert" ]; then
                cp "$cert" /etc/ssl/certs/
                log_info "Installed $(basename "$cert")"
            fi
        done
        update-ca-certificates
    elif [ -d "/etc/pki/ca-trust/source/anchors" ]; then
        # RHEL/CentOS style
        for cert in "$CERT_DIR"/*.crt; do
            if [ -f "$cert" ]; then
                cp "$cert" /etc/pki/ca-trust/source/anchors/
                log_info "Installed $(basename "$cert")"
            fi
        done
        update-ca-trust
    else
        log_warning "Unknown certificate store location. Please install certificates manually."
    fi
    
    # Clean up
    rm -rf "$CERT_DIR"
    
    log_success "Russian certificates installed"
}

# Setup Python certificates for requests
setup_python_certificates() {
    log_info "Setting up Python certificate verification..."
    
    # Get Python certificates location
    PYTHON_CERT_FILE=$(python3 -m certifi)
    
    if [ -f "$PYTHON_CERT_FILE" ]; then
        log_info "Python certificates file: $PYTHON_CERT_FILE"
        
        # Backup original certificates
        cp "$PYTHON_CERT_FILE" "${PYTHON_CERT_FILE}.backup"
        
        # Append system certificates to Python certificates
        if [ -f "/etc/ssl/certs/ca-certificates.crt" ]; then
            cat /etc/ssl/certs/ca-certificates.crt >> "$PYTHON_CERT_FILE"
        elif [ -f "/etc/pki/tls/certs/ca-bundle.crt" ]; then
            cat /etc/pki/tls/certs/ca-bundle.crt >> "$PYTHON_CERT_FILE"
        fi
        
        log_success "Python certificates updated"
    else
        log_warning "Could not locate Python certificates file"
    fi
}

# Install PR-Agent and dependencies
install_pr_agent() {
    log_info "Installing PR-Agent and dependencies..."
    
    # Install Python packages
    pip3 install --upgrade pip
    pip3 install certifi requests urllib3
    
    # Clone PR-Agent repository
    if [ ! -d "/opt/pr-agent-gigachat" ]; then
        git clone https://github.com/stp008/pr-agent-gigachat.git /opt/pr-agent-gigachat
    else
        log_info "PR-Agent already exists, updating..."
        cd /opt/pr-agent-gigachat
        git pull
    fi
    
    cd /opt/pr-agent-gigachat
    pip3 install -r requirements.txt
    
    log_success "PR-Agent installed"
}

# Install litellm-gigachat
install_litellm_gigachat() {
    log_info "Installing litellm-gigachat..."
    
    if [ ! -d "/opt/litellm-gigachat" ]; then
        git clone https://github.com/stp008/litellm-gigachat.git /opt/litellm-gigachat
    else
        log_info "litellm-gigachat already exists, updating..."
        cd /opt/litellm-gigachat
        git pull
    fi
    
    cd /opt/litellm-gigachat
    pip3 install -r requirements.txt
    
    log_success "litellm-gigachat installed"
}

# Create configuration files
create_configuration() {
    log_info "Creating configuration files..."
    
    # Create PR-Agent configuration
    mkdir -p /opt/pr-agent-gigachat/pr_agent/settings
    
    cat > /opt/pr-agent-gigachat/pr_agent/settings/.secrets.toml << 'EOF'
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
username = "YOUR_BITBUCKET_USERNAME"
password = "YOUR_BITBUCKET_PASSWORD"
EOF
    
    log_success "Configuration files created"
}

# Create wrapper scripts
create_wrapper_scripts() {
    log_info "Creating wrapper scripts..."
    
    # Create PR-Agent CLI wrapper
    cat > /usr/local/bin/pr-agent-cli << 'EOF'
#!/bin/bash

# PR-Agent CLI Wrapper Script
# Sets up environment and runs PR-Agent CLI commands

# Set environment variables
export PYTHONPATH="/opt/pr-agent-gigachat:$PYTHONPATH"
export CONFIG__MODEL="openai/gigachat-max"
export CONFIG__FALLBACK_MODELS='["openai/gigachat-pro"]'
export CONFIG__CUSTOM_MODEL_MAX_TOKENS=200000
export CONFIG__GIT_PROVIDER="bitbucket_server"
export OPENAI__API_BASE="http://localhost:4000"

# SSL/TLS settings for Russian environment
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
export CURL_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"

# Check if litellm-gigachat is running
if ! curl -s http://localhost:4000/health > /dev/null 2>&1; then
    echo "Warning: litellm-gigachat proxy is not running on localhost:4000"
    echo "Please start it with: sudo systemctl start litellm-gigachat"
    echo "Or manually: cd /opt/litellm-gigachat && python main.py"
fi

# Run PR-Agent CLI
cd /opt/pr-agent-gigachat
python3 -m pr_agent.cli "$@"
EOF

    chmod +x /usr/local/bin/pr-agent-cli
    
    # Create litellm-gigachat service script
    cat > /usr/local/bin/start-gigachat-proxy << 'EOF'
#!/bin/bash

# Start GigaChat Proxy Service

export PYTHONPATH="/opt/litellm-gigachat:$PYTHONPATH"

# SSL/TLS settings for Russian environment
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
export CURL_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"

cd /opt/litellm-gigachat
python3 main.py
EOF

    chmod +x /usr/local/bin/start-gigachat-proxy
    
    # Create systemd service for litellm-gigachat
    cat > /etc/systemd/system/litellm-gigachat.service << 'EOF'
[Unit]
Description=LiteLLM GigaChat Proxy
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/litellm-gigachat
Environment=PYTHONPATH=/opt/litellm-gigachat
Environment=REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
Environment=SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
Environment=CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
ExecStart=/usr/bin/python3 main.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable litellm-gigachat
    
    log_success "Wrapper scripts created"
}

# Create usage examples script
create_usage_examples() {
    log_info "Creating usage examples..."
    
    cat > /usr/local/bin/pr-agent-examples << 'EOF'
#!/bin/bash

# PR-Agent Usage Examples for Russian Environment

echo "=== PR-Agent CLI Examples ==="
echo ""
echo "Basic Commands:"
echo "  pr-agent-cli --pr_url=<bitbucket_url> describe"
echo "  pr-agent-cli --pr_url=<bitbucket_url> review"
echo "  pr-agent-cli --pr_url=<bitbucket_url> improve"
echo ""
echo "Advanced Examples:"
echo "  # Security-focused review"
echo "  pr-agent-cli --pr_url=<url> review --pr_reviewer.require_security_review=true --pr_reviewer.num_max_findings=10"
echo ""
echo "  # Generate commitable suggestions"
echo "  pr-agent-cli --pr_url=<url> improve --pr_code_suggestions.commitable_code_suggestions=true"
echo ""
echo "  # Custom description with AI title"
echo "  pr-agent-cli --pr_url=<url> describe --pr_description.generate_ai_title=true --pr_description.enable_pr_diagram=true"
echo ""
echo "Environment Setup:"
echo "  # Set Bitbucket credentials"
echo "  export BITBUCKET_SERVER__BEARER_TOKEN='your_token'"
echo "  export BITBUCKET_SERVER__URL='http://your-bitbucket-server:7990'"
echo ""
echo "Service Management:"
echo "  # Start GigaChat proxy"
echo "  sudo systemctl start litellm-gigachat"
echo "  sudo systemctl status litellm-gigachat"
echo ""
echo "  # Or start manually"
echo "  start-gigachat-proxy"
echo ""
echo "Configuration:"
echo "  # Edit configuration file"
echo "  sudo nano /opt/pr-agent-gigachat/pr_agent/settings/.secrets.toml"
echo ""
EOF

    chmod +x /usr/local/bin/pr-agent-examples
    
    log_success "Usage examples created"
}

# Main installation function
main() {
    log_info "Starting PR-Agent setup for Russian environment..."
    
    check_root
    install_dependencies
    install_russian_certificates
    setup_python_certificates
    install_pr_agent
    install_litellm_gigachat
    create_configuration
    create_wrapper_scripts
    create_usage_examples
    
    log_success "Installation completed!"
    echo ""
    log_info "Next steps:"
    echo "1. Edit configuration: sudo nano /opt/pr-agent-gigachat/pr_agent/settings/.secrets.toml"
    echo "2. Set your Bitbucket token: export BITBUCKET_SERVER__BEARER_TOKEN='your_token'"
    echo "3. Set your Bitbucket URL: export BITBUCKET_SERVER__URL='http://your-server:7990'"
    echo "4. Start GigaChat proxy: sudo systemctl start litellm-gigachat"
    echo "5. Run PR-Agent: pr-agent-cli --pr_url=<your_pr_url> describe"
    echo "6. View examples: pr-agent-examples"
    echo ""
    log_info "For troubleshooting, check logs: journalctl -u litellm-gigachat -f"
}

# Run main function
main "$@"
EOF
