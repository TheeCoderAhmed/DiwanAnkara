fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android generate_icons

```sh
[bundle exec] fastlane android generate_icons
```

Generate app icons from assets/icon/diwan-ankara-1024x1024.png

### android test

```sh
[bundle exec] fastlane android test
```

Run Flutter unit tests

### android bump_version

```sh
[bundle exec] fastlane android bump_version
```

Bump versionCode in pubspec.yaml

### android build

```sh
[bundle exec] fastlane android build
```

Build Flutter release AAB

### android deploy_internal

```sh
[bundle exec] fastlane android deploy_internal
```

Deploy to Internal Testing track

### android deploy_alpha

```sh
[bundle exec] fastlane android deploy_alpha
```

Deploy to Alpha track

### android deploy_beta

```sh
[bundle exec] fastlane android deploy_beta
```

Deploy to Beta track

### android deploy_production

```sh
[bundle exec] fastlane android deploy_production
```

Deploy to Production (10% staged rollout)

### android promote_internal_to_alpha

```sh
[bundle exec] fastlane android promote_internal_to_alpha
```

Promote Internal → Alpha (no re-upload)

### android promote_alpha_to_beta

```sh
[bundle exec] fastlane android promote_alpha_to_beta
```

Promote Alpha → Beta (no re-upload)

### android promote_beta_to_production

```sh
[bundle exec] fastlane android promote_beta_to_production
```

Promote Beta → Production (no re-upload)

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
