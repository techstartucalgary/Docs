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

# Why?

Application secrets are critical for security.
For example, if an attacker discovers the database credentials,
then immediately this attacker would gain access to all of the applications data.
Application secrets is the entrypoint for everything, they are the Keys of Heaven,
and therefore, it's very important to make sure
that only the right people can get access to those secrets.

In this line of making application secrets be only accessible to the right people
we also need to make sure that developers can only access development secrets.
It's very common to have at least 2 environments: Development and Production,
and to have some kind of segmentation where only super admins can access Production secrets.

It also doesn't matter if your source code is private,
you still want to protect your secrets because your source code may be leaked,
as it has happened in the past to companies like Twitch.

There is also an argument about maintainability.
Secrets are also configuration, namely, their values may change over time,
even if the source code doesn't. For this reason it's recommended to
[strictly separate them from the source code](https://12factor.net/config).

# Workshop Step by Step

## Git-Crypt

Enables you to encrypt/decrypt the parts of a git of repository.

Example:

<https://github.com/techstartucalgary/Docs/tree/main/src/workshops/secrets-management/secrets>

Key: [download](https://github.com/techstartucalgary/Docs/raw/main/src/workshops/secrets-management/unsafe/key) (Note: This should be distributed through a secure channel. For the sake of simplicity you can download it)

<!--
https://vault.kamadorueda.com/ui

vault operator init -address https://vault.kamadorueda.com

export VAULT_ADDR=https://vault.kamadorueda.com
vault login
vault kv get -address https://vault.kamadorueda.com  -field=password secret/kevin
-->
