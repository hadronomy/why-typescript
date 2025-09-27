<div align="center">
  <img src="/.github/images/github-header-image.webp#gh-dark-mode-only" alt="GitHub Header Image" width="auto" />
  <img src="/.github/images/github-header-image.webp#gh-light-mode-only" alt="GitHub Header Image" width="auto" />
  
  <!-- Badges -->
  <p></p> 
  <a href="https://github.com/hadronomy/why-typescript/blob/main/LICENSE">
    <img
      alt="License"
      src="https://img.shields.io/badge/MIT-EE999F?style=for-the-badge&logo=starship&label=LICENSE&labelColor=302D41"
    />
  </a>
  <p></p>
  <!-- TOC -->
  <a href="#why">Why</a> •
  <a href="#usage">Usage</a> •
  <a href="#usage">Results</a> •
  <a href="#license">License</a>
  <hr />
</div>

## Why ??

This repository contains an script to setup the `git bisect run` automated script and typescript test file, required
to find when was this weird behaviour introduced in typescript:

<a href="https://x.com/techsavvytravvy/status/1971820255375687722">
  <img
    alt="X"
    src="/.github/images/x.webp"
  />
</a>

## Usage

First clone the typescript repo

```sh
gh repo clone microsoft/TypeScript
```

Then run the setup script inside the `TypeScript` directory.

```sh
curl -L https://raw.githubusercontent.com/hadronomy/why-typescript/main/setup.sh | bash
```

## Results

From the bisect results it seems that this behavior was introduced with this pull request:

[![](https://pbs.twimg.com/card_img/1971931817738698752/t3a_FVt6?format=jpg&name=medium)](https://github.com/microsoft/TypeScript/pull/54448)

## License

This project is licensed under the MIT License -
see the [LICENSE](/LICENSE) file for details.