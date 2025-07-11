# Using PR-Agent CLI with Bitbucket Server and GigaChat

This guide describes how to use PR-Agent CLI (Command Line Interface) with Bitbucket Server, using the GigaChat model through litellm-gigachat.

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

### Environment Variables Setup

Set up the required environment variables for Bitbucket Server:

```bash
# Core configuration
export CONFIG__MODEL="openai/gigachat-max"
export CONFIG__FALLBACK_MODELS='["openai/gigachat-pro"]'
export CONFIG__CUSTOM_MODEL_MAX_TOKENS=200000
export CONFIG__GIT_PROVIDER="bitbucket_server"

# GigaChat API configuration
export OPENAI__API_BASE="http://localhost:4000"

# Bitbucket Server configuration
export BITBUCKET_SERVER__BEARER_TOKEN="YOUR_BITBUCKET_BEARER_TOKEN"
export BITBUCKET_SERVER__URL="http://your-bitbucket-server:7990"

# Optional: Logging
export LOG_LEVEL="INFO"
```

### Configuration File (Alternative)

Alternatively, create `pr_agent/settings/.secrets.toml`:

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

## Basic CLI Commands

### Command Syntax

```bash
python -m pr_agent.cli --pr_url=<bitbucket_pr_url> <command> [parameters]
```

Where `<bitbucket_pr_url>` follows the format:
```
http://your-bitbucket-server:7990/projects/PROJECT_KEY/repos/REPO_NAME/pull-requests/PR_ID
```

### Basic Commands

**Generate PR Description:**
```bash
python -m pr_agent.cli --pr_url=http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123 describe
```

**Perform Code Review:**
```bash
python -m pr_agent.cli --pr_url=http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123 review
```

**Get Code Improvement Suggestions:**
```bash
python -m pr_agent.cli --pr_url=http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123 improve
```

**Ask Questions about the PR:**
```bash
python -m pr_agent.cli --pr_url=http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123 ask "What is the main purpose of this PR?"
```

**Add Documentation:**
```bash
python -m pr_agent.cli --pr_url=http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123 add_docs
```

**Update Changelog:**
```bash
python -m pr_agent.cli --pr_url=http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123 update_changelog
```

**Generate Labels:**
```bash
python -m pr_agent.cli --pr_url=http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123 generate_labels
```

## Advanced CLI Examples with Parameters

### `/describe` Command Examples

**Basic description:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> describe
```

**Disable final update message:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> describe --pr_description.final_update_message=false
```

**Generate AI title for the PR:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> describe --pr_description.generate_ai_title=true
```

**Add custom instructions:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> describe --pr_description.extra_instructions="Focus on security and performance aspects"
```

**Publish description as comment:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> describe --pr_description.publish_description_as_comment=true
```

**Enable PR diagram:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> describe --pr_description.enable_pr_diagram=true
```

**Disable bullet points format:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> describe --pr_description.use_bullet_points=false
```

### `/review` Command Examples

**Basic code review:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review
```

**Incremental review (only new changes):**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review -i
```

**Review with security focus:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review --pr_reviewer.require_security_review=true
```

**Limit number of findings:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review --pr_reviewer.num_max_findings=5
```

**Disable help text in review:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review --pr_reviewer.enable_help_text=false
```

**Enable effort estimation labels:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review --pr_reviewer.enable_review_labels_effort=true
```

**Require test coverage analysis:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review --pr_reviewer.require_tests_review=true
```

**Add custom review instructions:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review --pr_reviewer.extra_instructions="Pay special attention to error handling and edge cases"
```

**Comprehensive security review:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> review --pr_reviewer.require_security_review=true --pr_reviewer.require_tests_review=true --pr_reviewer.num_max_findings=10
```

### `/improve` Command Examples

**Basic code suggestions:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve
```

**Generate commitable suggestions:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve --pr_code_suggestions.commitable_code_suggestions=true
```

**Focus only on problems:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve --pr_code_suggestions.focus_only_on_problems=true
```

**Extended mode with more suggestions:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve --extended
```

**Set suggestion score threshold:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve --pr_code_suggestions.suggestions_score_threshold=7
```

**Enable chat functionality:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve --pr_code_suggestions.enable_chat_text=true
```

**Add custom improvement instructions:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve --pr_code_suggestions.extra_instructions="Focus on performance optimizations and memory usage"
```

**Disable help text:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve --pr_code_suggestions.enable_help_text=false
```

**High-quality suggestions only:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> improve --pr_code_suggestions.commitable_code_suggestions=true --pr_code_suggestions.suggestions_score_threshold=8 --pr_code_suggestions.focus_only_on_problems=true
```

### `/ask` Command Examples

**Ask a general question:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> ask "What is the main purpose of this PR?"
```

**Ask about specific functionality:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> ask "How does the new authentication mechanism work?"
```

**Ask about performance implications:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> ask "What are the performance implications of these changes?"
```

**Ask about testing:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> ask "What additional tests should be added for this feature?"
```

**Ask about security:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> ask "Are there any security concerns with this implementation?"
```

### `/add_docs` Command Examples

**Add documentation with default style:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> add_docs
```

**Specify documentation style:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> add_docs --pr_add_docs.docs_style="Google Style with Args, Returns, Attributes...etc"
```

**Add docs for specific file:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> add_docs --pr_add_docs.file="src/main.py"
```

**Add docs for specific class:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> add_docs --pr_add_docs.class_name="UserManager"
```

**Use Sphinx style documentation:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> add_docs --pr_add_docs.docs_style="Sphinx Style"
```

**Use Numpy style documentation:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> add_docs --pr_add_docs.docs_style="Numpy Style"
```

### `/update_changelog` Command Examples

**Update changelog:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> update_changelog
```

**Update changelog and push changes:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> update_changelog --pr_update_changelog.push_changelog_changes=true
```

**Add PR link to changelog:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> update_changelog --pr_update_changelog.add_pr_link=true
```

**Skip CI on changelog push:**
```bash
python -m pr_agent.cli --pr_url=<pr_url> update_changelog --pr_update_changelog.skip_ci_on_push=true
```

## Practical Usage Scenarios

### Complete PR Analysis Workflow

```bash
#!/bin/bash
PR_URL="http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123"

# Step 1: Generate comprehensive description
python -m pr_agent.cli --pr_url=$PR_URL describe --pr_description.generate_ai_title=true --pr_description.enable_pr_diagram=true

# Step 2: Perform thorough security review
python -m pr_agent.cli --pr_url=$PR_URL review --pr_reviewer.require_security_review=true --pr_reviewer.require_tests_review=true --pr_reviewer.num_max_findings=10

# Step 3: Get high-quality improvement suggestions
python -m pr_agent.cli --pr_url=$PR_URL improve --pr_code_suggestions.commitable_code_suggestions=true --pr_code_suggestions.suggestions_score_threshold=7

# Step 4: Add documentation if needed
python -m pr_agent.cli --pr_url=$PR_URL add_docs --pr_add_docs.docs_style="Google Style with Args, Returns, Attributes...etc"

# Step 5: Update changelog
python -m pr_agent.cli --pr_url=$PR_URL update_changelog --pr_update_changelog.add_pr_link=true
```

### Security-Focused Review

```bash
#!/bin/bash
PR_URL="http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123"

# Security-focused review
python -m pr_agent.cli --pr_url=$PR_URL review \
  --pr_reviewer.require_security_review=true \
  --pr_reviewer.num_max_findings=15 \
  --pr_reviewer.extra_instructions="Focus on security vulnerabilities, input validation, and authentication mechanisms"

# Security-focused improvements
python -m pr_agent.cli --pr_url=$PR_URL improve \
  --pr_code_suggestions.focus_only_on_problems=true \
  --pr_code_suggestions.extra_instructions="Focus on security vulnerabilities and potential attack vectors" \
  --pr_code_suggestions.suggestions_score_threshold=8
```

### CI/CD Integration

**GitHub Actions Example:**
```yaml
name: PR-Agent Analysis
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  pr-analysis:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'
      
      - name: Install PR-Agent
        run: |
          pip install -r requirements.txt
      
      - name: Run PR Analysis
        env:
          CONFIG__GIT_PROVIDER: "bitbucket_server"
          BITBUCKET_SERVER__BEARER_TOKEN: ${{ secrets.BITBUCKET_TOKEN }}
          BITBUCKET_SERVER__URL: "http://your-bitbucket-server:7990"
          OPENAI__API_BASE: "http://localhost:4000"
        run: |
          python -m pr_agent.cli --pr_url=${{ github.event.pull_request.html_url }} describe
          python -m pr_agent.cli --pr_url=${{ github.event.pull_request.html_url }} review
          python -m pr_agent.cli --pr_url=${{ github.event.pull_request.html_url }} improve
```

**Jenkins Pipeline Example:**
```groovy
pipeline {
    agent any
    
    environment {
        CONFIG__GIT_PROVIDER = "bitbucket_server"
        BITBUCKET_SERVER__BEARER_TOKEN = credentials('bitbucket-token')
        BITBUCKET_SERVER__URL = "http://your-bitbucket-server:7990"
        OPENAI__API_BASE = "http://localhost:4000"
    }
    
    stages {
        stage('PR Analysis') {
            steps {
                script {
                    def prUrl = "http://bitbucket-server:7990/projects/${env.PROJECT_KEY}/repos/${env.REPO_NAME}/pull-requests/${env.PR_ID}"
                    
                    sh "python -m pr_agent.cli --pr_url=${prUrl} describe"
                    sh "python -m pr_agent.cli --pr_url=${prUrl} review"
                    sh "python -m pr_agent.cli --pr_url=${prUrl} improve"
                }
            }
        }
    }
}
```

### Batch Processing Multiple PRs

```bash
#!/bin/bash
# Process multiple PRs in batch

BASE_URL="http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests"
PR_IDS=(123 124 125 126)

for PR_ID in "${PR_IDS[@]}"; do
    echo "Processing PR $PR_ID..."
    PR_URL="$BASE_URL/$PR_ID"
    
    # Quick analysis for each PR
    python -m pr_agent.cli --pr_url=$PR_URL describe --pr_description.final_update_message=false
    python -m pr_agent.cli --pr_url=$PR_URL review --pr_reviewer.num_max_findings=3
    
    echo "Completed PR $PR_ID"
done
```

### Local Development Workflow

```bash
#!/bin/bash
# Local development helper script

# Set local configuration
export CONFIG__PUBLISH_OUTPUT=false
export CONFIG__VERBOSITY_LEVEL=2

PR_URL="http://bitbucket-server:7990/projects/PROJ/repos/myrepo/pull-requests/123"

# Local analysis without publishing
python -m pr_agent.cli --pr_url=$PR_URL describe
python -m pr_agent.cli --pr_url=$PR_URL review
python -m pr_agent.cli --pr_url=$PR_URL improve

echo "Analysis complete. Results saved locally."
```

## Configuration Parameters Reference

### Common Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `final_update_message` | Show final update message | `true` | `--pr_description.final_update_message=false` |
| `extra_instructions` | Additional instructions for AI | `""` | `--pr_reviewer.extra_instructions="Focus on performance"` |
| `enable_help_text` | Show help text in output | `false` | `--pr_reviewer.enable_help_text=true` |
| `publish_output` | Publish results to PR | `true` | `--config.publish_output=false` |
| `verbosity_level` | Logging verbosity (0-2) | `0` | `--config.verbosity_level=2` |

### `/describe` Specific Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `generate_ai_title` | Generate AI title for PR | `false` | `--pr_description.generate_ai_title=true` |
| `use_bullet_points` | Use bullet points format | `true` | `--pr_description.use_bullet_points=false` |
| `enable_pr_diagram` | Add PR changes diagram | `true` | `--pr_description.enable_pr_diagram=false` |
| `publish_description_as_comment` | Publish as comment instead of updating PR | `false` | `--pr_description.publish_description_as_comment=true` |
| `add_original_user_description` | Keep original description | `true` | `--pr_description.add_original_user_description=false` |

### `/review` Specific Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `require_security_review` | Include security analysis | `true` | `--pr_reviewer.require_security_review=false` |
| `require_tests_review` | Analyze test coverage | `true` | `--pr_reviewer.require_tests_review=false` |
| `num_max_findings` | Maximum number of findings | `3` | `--pr_reviewer.num_max_findings=5` |
| `enable_review_labels_effort` | Add effort estimation labels | `true` | `--pr_reviewer.enable_review_labels_effort=false` |
| `require_score_review` | Include score in review | `false` | `--pr_reviewer.require_score_review=true` |
| `require_can_be_split_review` | Check if PR can be split | `false` | `--pr_reviewer.require_can_be_split_review=true` |

### `/improve` Specific Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `commitable_code_suggestions` | Generate commitable suggestions | `false` | `--pr_code_suggestions.commitable_code_suggestions=true` |
| `focus_only_on_problems` | Focus only on problems | `true` | `--pr_code_suggestions.focus_only_on_problems=false` |
| `suggestions_score_threshold` | Minimum score for suggestions | `0` | `--pr_code_suggestions.suggestions_score_threshold=7` |
| `enable_chat_text` | Enable chat functionality | `false` | `--pr_code_suggestions.enable_chat_text=true` |
| `max_context_tokens` | Maximum context tokens | `24000` | `--pr_code_suggestions.max_context_tokens=16000` |
| `num_code_suggestions_per_chunk` | Suggestions per chunk | `4` | `--pr_code_suggestions.num_code_suggestions_per_chunk=6` |

### `/add_docs` Specific Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `docs_style` | Documentation style | `"Sphinx"` | `--pr_add_docs.docs_style="Google Style with Args, Returns, Attributes...etc"` |
| `file` | Specific file to document | `""` | `--pr_add_docs.file="src/main.py"` |
| `class_name` | Specific class to document | `""` | `--pr_add_docs.class_name="UserManager"` |

## Troubleshooting

### Common Issues

**1. Authentication Error:**
```
Error: Authentication failed
```
**Solution:** Check your Bearer Token and ensure it has proper permissions:
```bash
export BITBUCKET_SERVER__BEARER_TOKEN="your_valid_token"
```

**2. Connection Error:**
```
Error: Cannot connect to Bitbucket Server
```
**Solution:** Verify the Bitbucket Server URL:
```bash
export BITBUCKET_SERVER__URL="http://your-bitbucket-server:7990"
```

**3. GigaChat API Error:**
```
Error: Cannot connect to GigaChat API
```
**Solution:** Ensure litellm-gigachat is running:
```bash
# Check if the proxy is running
curl http://localhost:4000/health

# If not running, start it
cd litellm-gigachat
python main.py
```

**4. Invalid PR URL:**
```
Error: Invalid PR URL format
```
**Solution:** Use the correct Bitbucket Server URL format:
```
http://your-bitbucket-server:7990/projects/PROJECT_KEY/repos/REPO_NAME/pull-requests/PR_ID
```

**5. Permission Denied:**
```
Error: Insufficient permissions
```
**Solution:** Ensure your Bearer Token has the following permissions:
- Repository read access
- Pull request read/write access
- Comment creation permissions

### Debug Mode

Enable debug logging for troubleshooting:

```bash
export LOG_LEVEL="DEBUG"
export CONFIG__VERBOSITY_LEVEL=2
python -m pr_agent.cli --pr_url=<pr_url> <command>
```

### Local Testing

Test without publishing to PR:

```bash
export CONFIG__PUBLISH_OUTPUT=false
python -m pr_agent.cli --pr_url=<pr_url> <command>
```

### Health Check

Verify your setup with a simple command:

```bash
python -m pr_agent.cli --pr_url=<pr_url> ask "Is this setup working correctly?"
```

## Best Practices

1. **Use Environment Variables:** Store sensitive information like tokens in environment variables, not in scripts.

2. **Test Locally First:** Use `--config.publish_output=false` to test commands locally before publishing.

3. **Customize for Your Workflow:** Adjust parameters based on your team's needs and coding standards.

4. **Batch Processing:** For multiple PRs, use scripts to automate the process.

5. **CI/CD Integration:** Integrate PR-Agent into your CI/CD pipeline for automated analysis.

6. **Monitor Usage:** Keep track of API usage and adjust parameters to optimize performance.

7. **Regular Updates:** Keep PR-Agent and litellm-gigachat updated for the latest features and improvements.
