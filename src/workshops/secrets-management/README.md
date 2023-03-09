# Secrets Management

In this Workshop, we'll learn how to properly store the secrets
that your application's source code needs to run
like database connection strings and third-party API access credentials,
and do so even if people have access to your source code.

We'll be exploring three approaches used in industry,
and talking about when to use one or the other:

1. [Git Crypt](https://github.com/AGWA/git-crypt).
2. [SOPS](https://github.com/mozilla/sops) - My favorite.
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

> https://github.com/AGWA/git-crypt

Enables you to encrypt/decrypt the parts of a git of repository.

The good:

- Versioned as code.
- It's simple to use.
- Great for a simple project, with no compliance needs.

The bad:

- You cannot have multiple keys. All people share the same encryption key,
  which means you cannot isolate environments,
  and therefore is not that useful in highly regulated industries.
- Unencrypted secrets touch the disk,
  which is not great if someone steals your laptop while unencrypted.

Steps:

1. Visit <https://github.com/techstartucalgary/Docs/tree/main/src/workshops/secrets-management/git-crypt/secrets>.

   As you can see, there are `dev` and `prod` secrets with `username` and `password`, but they are encrypted, so we cannot see them unless we have they key.

1. Download the key [here](https://github.com/techstartucalgary/Docs/raw/main/src/workshops/secrets-management/git-crypt/unsafe/key)

   Note: This should be distributed through a secure channel (e.g. encrypted email).
   For the sake of simplicity you can download it here.

1. Now we want to decrypt the secrets, for this we have to:

   ```sh
   $ git clone https://github.com/techstartucalgary/Docs.git docs
   $ cd docs

   docs $ cat src/workshops/secrets-management/git-crypt/secrets/dev/username
     <you should see gibberish>

   # Decrypt
   docs $ git-crypt unlock /path/to/key

   # You should see the secrets now
   docs $ cat src/workshops/secrets-management/git-crypt/secrets/dev/username
   docs $ cat src/workshops/secrets-management/git-crypt/secrets/dev/password

   # Encrypt
   docs $ git-crypt lock
   docs $ cat src/workshops/secrets-management/git-crypt/secrets/dev/username
     <you should see gibberish again>
   ```

1. The next step is understanding how it works, so essentially you configure which paths of the repository are encrypted in a `.gitattributes` file like this one:
   <https://github.com/techstartucalgary/Docs/blob/main/src/workshops/secrets-management/git-crypt/.gitattributes>,
   where essentially we tell git-crypt to encrypt the files under the secrets/ folder. You can check which files are encrypted with

   ```sh
   $ git-crypt status
      not encrypted: src/workshops/secrets-management/README.md
          encrypted: src/workshops/secrets-management/git-crypt/secrets/dev/password
          encrypted: src/workshops/secrets-management/git-crypt/secrets/dev/username
          encrypted: src/workshops/secrets-management/git-crypt/secrets/prod/password
          encrypted: src/workshops/secrets-management/git-crypt/secrets/prod/username
      not encrypted: src/workshops/secrets-management/git-crypt/unsafe/key
   ```

## Sops

> https://github.com/mozilla/sops

Enables you to encrypt/decrypt JSON, YAML, or whole files.

The good:

- Versioned as code.
- You can have multiple keys and access control over a whole file,
  great for highly regulated industries.
- Keys can be connected to an AWS/GCP/Azure identity,
  which is great in corporate environments,
  and Age/PGP, which is great for other environments.

The neutral:

- Not that easy to use, but reasonable given the features.

The bad:

- Requires some training to get used to it.

Steps:

1. Visit <https://github.com/techstartucalgary/Docs/tree/main/src/workshops/secrets-management/sops>.

   As you can see, there are `dev` and `prod` secrets with `username` and `password`, but they are encrypted, so we cannot see them unless we have they key.

1. Download the development key
   [here](https://github.com/techstartucalgary/Docs/raw/main/src/workshops/secrets-management/sops/unsafe/dev-key.txt)
   and the production key
   [here](https://github.com/techstartucalgary/Docs/raw/main/src/workshops/secrets-management/sops/unsafe/prod-key.txt)

   Note: This should be distributed through a secure channel (e.g. encrypted email).
   For the sake of simplicity you can download it here.

1. Now we want to decrypt the secrets, for this we have to:

   ```sh
   $ git clone https://github.com/techstartucalgary/Docs.git docs
   $ cd docs

   $ cd src/workshops/secrets-management/sops

   src/workshops/secrets-management/sops $ cat dev.yaml
     <you should see gibberish>

   src/workshops/secrets-management/sops $ cat prod.yaml
     <you should see gibberish>

   # Decrypt dev secrets with dev key
   src/workshops/secrets-management/sops $ SOPS_AGE_KEY_FILE=/path/to/dev/key sops -d dev.yaml

   # Decrypt prod secrets with dev key
   src/workshops/secrets-management/sops $ SOPS_AGE_KEY_FILE=/path/to/dev/key sops -d prod.yaml
      <you should see a failure, wrong key>

   # Decrypt prod secrets with prod key
   src/workshops/secrets-management/sops $ SOPS_AGE_KEY_FILE=/path/to/prod/key sops -d prod.yaml
   ```

## Vault

> <https://www.hashicorp.com/products/vault>

The good:

- Big enterprises like it. Why? Maybe marketing? I assume is because it allows for centralization, which is important if you have hundreds of teams.

The neutral:

- Very flexible.

The bad:

- Another server to maintain.
- Not versioned as code.
- Not free.

> Note: <https://vault.kamadorueda.com> will be only available during the workshop. If you are following this guide after the workshop, please use your own Vault instance instead.

Steps:

1. Login to the UI at <https://vault.kamadorueda.com/ui>. The token is `123`.

1. Let's put and get a secret out of it

   ```sh
   $ export VAULT_ADDR=https://vault.kamadorueda.com

   # Login. The token is: 123
   $ vault login

   $ vault kv put secret/your-name password=your-password

   $ vault kv get -field=password secret/your-name
   ```

1. It's possible to define access control lists, policies, and grant each person a different token, or login with OIDC. It's very flexible.
