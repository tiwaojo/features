# Dev Container Features
A collection of devcontainer features to use in GitHub Codespaces/Dev Containers.

## MCAP (mcap-cli)

Installs the `mcap` cli tool into the devcontainer from [source](https://github.com/foxglove/mcap/releases) and adds the [MCAP VSCode extension](https://marketplace.visualstudio.com/items?itemName=mcap-cli-vscode.mcap-cli-vscode)

### Example Usage

```json
"features": {
  "ghcr.io/tiwaojo/features/mcap:latest": {}
}
```
#### Using private Features in Codespaces

For any Features hosted in GHCR that are kept private, the `GITHUB_TOKEN` access token in your environment will need to have `package:read` and `contents:read` for the associated repository.

Many implementing tools use a broadly scoped access token and will work automatically.  GitHub Codespaces uses repo-scoped tokens, and therefore you'll need to add the permissions in `devcontainer.json`

An example `devcontainer.json` can be found below.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
     "ghcr.io/my-org/private-features/hello:1": {
            "greeting": "Hello"
        }
    },
    "customizations": {
        "codespaces": {
            "repositories": {
                "my-org/private-features": {
                    "permissions": {
                        "packages": "read",
                        "contents": "read"
                    }
                }
            }
        }
    }
}
```
