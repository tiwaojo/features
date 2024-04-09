# Dev Container Features
A collection of devcontainer features to use in GitHub Codespaces/Dev Containers.

## MCAP (mcap-cli)

Installs the `mcap` cli tool into the devcontainer from [source](https://github.com/foxglove/mcap/releases) and adds the [MCAP VSCode extension](https://marketplace.visualstudio.com/items?itemName=mcap-cli-vscode.mcap-cli-vscode)

### Example Usage

```json
"features": {
  "ghcr.io/tiwaojo/features/mcap-cli:latest": {}
}
```
