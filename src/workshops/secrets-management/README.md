# Secrets Management

In this Workshop, we'll learn how to properly store the secrets
that your application's source code needs to run
like database connection strings and third-party API access credentials,
and do so even if people have access to your source code.

We'll be exploring three approaches used in industry,
and talking about when to use one or the other:

1. [Git Crypt](https://github.com/AGWA/git-crypt).
2. [SOPS](https://github.com/mozilla/sops).
3. [Hashicorp's Vault](https://www.hashicorp.com/products/vault).

We'll also talk a little bit about the [Twelve-Factor app](https://12factor.net/),
particularly about factor #3: Configuration.

## Pre-requisites

To be able to focus on the important aspects of this Workshop (secrets management)
and avoid distractions we'll assume you are familiar with Git
and the command line.

Please bring your laptop,
the idea is that we'll work together step by step on small exercises
that will teach you each of the tools.

Only MacOS and Linux are supported.
If you are on Windows,
please [install WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

Please come to the workshop with the following tools ready to be used:

1. A terminal where you can enter commands, set environment variables, etc.
1. Git.
1. Git Crypt:

   Run `$ brew install git-crypt` on MacOS,
   or `$ apt install git-crypt` or similar on Linux/WSL.

1. Sops:

   Run `$ brew install sops` on MacOS,
   or `$ apt install sops` or similar on Linux/WSL.

1. [Age](https://github.com/FiloSottile/age):

   Run `$ brew install age` on MacOS,
   or `$ apt install age` or similar on Linux/WSL.

1. Vault:

   Please follow the instructions here:
   <https://developer.hashicorp.com/vault/downloads>.

# Workshop Step by Step

This section will be published on the day of the workshop.

<!--
https://vault.kamadorueda.com/ui

vault operator init -address https://vault.kamadorueda.com

export VAULT_ADDR=https://vault.kamadorueda.com
vault login
vault kv get -address https://vault.kamadorueda.com  -field=password secret/kevin
-->
