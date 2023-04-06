# Optimus - Gitpod Community Discord Bot

This repo contains the code that runs the Gitpod Community Discord Bot.

Community contribuitions are welcome! 🧡 Please create an issue and open a Gitpod workspace from that context.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gitpod-io/optimus)

## Contributing

You wanna contribute!? That sounds awesome! Thank you for taking the step to contribute towards this project :)

## Getting started

### Creating a Bot application on Discord's dev portal

- Login on https://discord.com/developers/applications
- Create a new app by clicking on `New Application` on the top right
- Inside your bot page, click on 🧩 `Bot` from the left sidebar and then `Add Bot` button
    - In the same page, toggle on the following options: `Presence Intent`, `Server Members Intent` and `Message Content Intent`
- Go to **OAuth2 > URL Generator** from your left sidebar
    - Tick `Scopes: bot, application.commands` and `Bot permissions: Adminstrator`. It should look like below:
    ![OAuth2 example](/.assets/oauth2_example.png)
    - Scroll to the bottom of this page and copy paste the **GENERATED-URL** into your browser tab to add the bot to a discord server. I recommend creating a new Discord server for bot development purposes.

### Running the BOT from Gitpod for development

- Update/fill-up [./BotConfig.toml](./BotConfig.toml) with:
  - The token from your 🧩 `Bot` page on discord dev portal. You might need to reset it to see.
  ![bot token](/.assets/bot_token_example.png)
  - The **Application ID** from the `General Information` section in your left sidebar
- In Gitpod terminal, run the BOT in the following manner:
```bash
cargo run
```

> **Note**
> You can also explicitly pass a path for your config.
> For example:
```bash
# For cargo
# $PWD = on Gitpod it'd be `/workspace/optimus`
cargo run -- $PWD/BotConfig.toml

# For a release binary
./target/release/optimus /some/arbitrary/path/to/your_config.toml
```

### Meilisearch and GitHub integration

Some (optional) features use Meilisearch and GitHub API.

Note: This part is very much undocumented, will be done soon.


### Deploying to GCP and others

#### GCP

- Create a **f1-micro** (~600MB RAM) Linux VM from **Compute Engine > VM Instances**. For example, with `gcloud` CLI:

```bash
gcloud compute instances create discord-optimus-bot \
    --zone=us-central1-a \
    --machine-type=f1-micro \
    --network-interface=network-tier=PREMIUM,subnet=default \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --create-disk=auto-delete=yes,boot=yes,device-name=discord-optimus-bot,image=projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2204-jammy-v20230302,mode=rw,size=10 \
    --no-shielded-secure-boot \
    --no-shielded-vtpm \
    --no-shielded-integrity-monitoring \
    --labels=ec-src=vm_add-gcloud \
    --reservation-affinity=any
```

- WIP (will be written soon)
