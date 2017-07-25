# SLAPI Brain - Redis

Redis container w/ API that enables SLAPI Bot to utilize Redis as a bot brain
## Prerequisites
-   Docker 1.10 or later

## Usage

### Config
Config required SLAPI config file `bot.yml`

```yaml
# Adapter Settings
brain:
  service: redis # Enables option alternative adapters
  container_config:
    Image: slapi/brain-redis:latest # Brain Dockerhub Image
    HostConfig:
      Binds: ["/local/path/brain/:/data"]
      PortBindings:
        4700/tcp:
          -
            HostIp: '0.0.0.0'
            HostPort: '4700' # de-conflict with slapi port and adapter port
 ```
## Testing

## How to Contribute

### External Contributors

-   Fork the repo on GitHub
-   Clone the project to your own machine
-   Commit changes to your own branch
-   Push your work back up to your fork
-   Submit a Pull Request so that we can review your changes

**NOTE**: Be sure to merge the latest from "upstream" before making a pull request!

### Internal Contributors

-   Clone the project to your own machine
-   Create a new branch from master
-   Commit changes to your own branch
-   Push your work back up to your branch
-   Submit a Pull Request so the changes can be reviewed

**NOTE**: Be sure to merge the latest from "upstream" before making a pull request!