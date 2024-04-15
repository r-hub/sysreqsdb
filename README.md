
## This repository is now archived in favor of https://github.com/rstudio/r-system-requirements

# sysreqs

> SystemRequirements for R packages

## Superseded!

This project is replaced by a new database [rstudio/r-system-requirements](https://github.com/rstudio/r-system-requirements), which is used by `pak` and `rhub2`.  

## Introduction

Many R packages require system libraries or other external software to build
or run. The `SystemRequirements` field in the package `DESCRIPTION` file should
declare these dependencies, as free form text. This makes it difficult to
automate building and checking of R packages, since we need to guess which
software should be installed on the build machine.

The `sysreqs` project formalizes these requirements, and provides a database
with API to quickly find out which Homebrew, Debian, Ubuntu, RHEL/Centos, etc
packages or other software needs to be available to build and use R packages.

In this README:

* [supported platforms](#supported-platforms)
* [the database format](#database-format)
* [how to contribute](#contributing)
* [how to access the data](#database-access)
* [where the `sysreqs` project is used](#use-cases-of-the-database)

## Supported platforms

Distributions using `deb` package format:
* Ubuntu Linux
* Debian Linux

Distributions using `rpm` package format:
* Fedora Linux (recent releases)
* RedHat and CentOS Linux (recent releases)

Distributions using the `PKGBUILD` package format:
* Arch Linux

Non-native package formats:
* HomeBrew package manager on MacOS
* Pacman/Rtools on Windows (forthcoming)

## Database format

The `sysreqs` database is a JSON document store. Each document contains
mappings for a single canonical system requirement. It contains both
the mappings to `SystemRequirements` fields, and platform dependent packages
or URLs.

Below an example to make this clear. Several R packages require the libxml2
library. For building these packages from source, the libxml2 development
headers are needed as well. The R packages refer to libxml2 in different
ways. E.g. [`igraph`](https://cran.r-project.org/web/packages/igraph/index.html) has simply `libxml2` and [`XML`](https://cran.r-project.org/web/packages/XML/index.html) has `libxml2 (>= 2.6.3)`
in their `SystemRequirements` fields.

```json
{
  "libxml2": {
    "sysreqs": "libxml2",
    "platforms": {
       "DEB": "libxml2-dev",
       "OSX/brew": null,
       "RPM": "libxml2-devel"
    }
  }
}
```

Some notes:
* The `sysreqs` field can be a string or array, and its entries can be fixed
  strings or regular expressions (when starting and ending with a forward slash, only [JavaScript RegExp](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp) are supported. [Example of a list `sysreqs` field](https://github.com/r-hub/sysreqsdb/blob/9c0acc932a11b1eb9f1600e27ca39a4d7deb0425/sysreqs/cairo.json#L3), [example of a `sysreqs` field with a regular expression](https://github.com/r-hub/sysreqsdb/blob/9c0acc932a11b1eb9f1600e27ca39a4d7deb0425/sysreqs/imagemagick.json#L3).
* Not all platforms have the same information, For `DEB` based Linux
  flavours (Debian, Ubuntu, etc.) packages that can be installed via the
  host package manager are listed: [`DEB` line example](https://github.com/r-hub/sysreqsdb/blob/9c0acc932a11b1eb9f1600e27ca39a4d7deb0425/sysreqs/cmake.json#L5). For Windows, typically URLs that have
  to be downloaded and installed: [Windows lines example](https://github.com/r-hub/sysreqsdb/blob/9c0acc932a11b1eb9f1600e27ca39a4d7deb0425/sysreqs/cmake.json#L8).
* `null` for `OSX/brew` means that nothing is needed, the system includes
  the requirement(s) by default. [Example](https://github.com/r-hub/sysreqsdb/blob/92ab711e2ddd5aa8ebb93f6a1fdc1d2b9012bc75/sysreqs/libbi.json#L5).

## Database access

See API docs at <https://sysreqs.r-hub.io/>

## Contributing

Your contributions are welcome! More details below.

### Adding or completing entries

Please read about [the data format](#database-format) first. Entries should be added or improved via pull requests.

* If a package (of yours or not) has a dependency that's not listed here yet, open a pull request to add it. You don't need to have it mapped to all platforms yet. [Example of such a PR](https://github.com/r-hub/sysreqsdb/pull/46).

* You can also make a pull request to add a mapping to a platform. [Example of such a PR](https://github.com/r-hub/sysreqsdb/pull/47).

### Reporting your use case

If you maintain a public platform/tool using sysreqsdb, make a PR to this repo updating the [section below](#use-cases-of-the-database). Please put your tool at the very end of the list.

## Use cases of the database

* [R-hub](https://builder.r-hub.io/)

* The [`codemetar` package](https://github.com/ropensci/codemetar), R package for the [CodeMeta project](https://codemeta.github.io/), uses the sysreqs API to parse the SystemRequirements field.

* The [`containerit` package](https://github.com/o2r-project/containerit) uses the sysreqs API to derive system requirements of packages for automatically creating a Dockerfile based on a collection of packages.

## License

MIT © The R Consortium
