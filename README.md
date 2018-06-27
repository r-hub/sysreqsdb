
# sysreqs

> SystemRequirements for R packages

## Introduction

Many R packages require external libraries or other external software to
run. The `SystemRequirements` field in the `DESCRIPTION` file should declare
these dependencies, as free form text. This makes it somewhat hard to
create automatic builds of R packages, since it is hard to guess what
software needs to be installed on the build machine.

The `sysreqs` project formalizes these requirements, and provides a database
with API, that can be used to quickly find out what Debian, Ubuntu,
RedHat, brew, etc. packages or other external software needs to be installed
to run or build R packages.

In this README learn 

* [which platforms are supported](#supported-platforms)
* [what's the database format](#database-format)
* [how to contribute](#contributing)
* [how to access the data](#database-access)
* [where the `sysreqs` project is used](#use-cases-of-the-database)


## Supported platforms

Planned:
* Ubuntu Linux (recent releases)
* Debian Linux (recent releases)
* Fedora Linux (recent releases)
* RedHat and CentOS Linux (recent releases)
* Mac OS X with the brew package manager
* Windows

## Database format

The `sysreqs` database is a JSON document store. Each document contains
mappings for a single canonical system requirement. It contains both
the mappings to `SystemRequirements` fields, and platform dependent packages
or URLs.

Here is an example to make this clear. Many R packages require the libxml2
library. For installing these packages from source, the libxml2 development
headers are also needed. Various R packages refer to libxml2 in different
ways. E.g. [`igraph`](https://cran.r-project.org/web/packages/igraph/index.html) has simply `libxml2` and [`XML`](https://cran.r-project.org/web/packages/XML/index.html) has `libxml2 (>= 2.6.3)`
in their `SystemRequirements` fields.

```json
{
  "libsecret": {
    "sysreqs": "/\\blibsecret\\b/",
    "platforms": {
      "DEB": "libsecret-1-dev",
      "OSX/brew": "libsecret",
      "RPM": "libsecret-devel"
    }
  }
}
```

Some notes:
* The `sysreqs` field can be a list, and its entries can be regular
  expressions (when starting and ending with a forward slash). [Example of a list `sysreqs` field](https://github.com/r-hub/sysreqsdb/blob/9c0acc932a11b1eb9f1600e27ca39a4d7deb0425/sysreqs/cairo.json#L3), [example of a `sysreqs` field with a regular expression](https://github.com/r-hub/sysreqsdb/blob/9c0acc932a11b1eb9f1600e27ca39a4d7deb0425/sysreqs/imagemagick.json#L3).
* Not all platforms have the same information, For `DEB` based Linux
  flavours (Debian, Ubuntu, etc.) packages that can be installed via the
  host package manager are listed: [`DEB` line example](https://github.com/r-hub/sysreqsdb/blob/9c0acc932a11b1eb9f1600e27ca39a4d7deb0425/sysreqs/cmake.json#L5). For Windows, typically URLs that have
  to be downloaded and installed: [Windows lines example](https://github.com/r-hub/sysreqsdb/blob/9c0acc932a11b1eb9f1600e27ca39a4d7deb0425/sysreqs/cmake.json#L8).
* `null` for `OSX/brew` means that nothing is needed, the system includes
  the requirement(s) by default. [Example](https://github.com/r-hub/sysreqsdb/blob/92ab711e2ddd5aa8ebb93f6a1fdc1d2b9012bc75/sysreqs/libbi.json#L5)

## Database access

See API docs at <https://sysreqs.r-hub.io/>

## Contributing

Your contributions are welcome! More details below.

### Adding or completing entries

Please read about [the data format](#database-format) first. Entries should be added or improved via pull requests.

* If a package (of yours or not) has a dependency that's not listed here yet, open a pull request to add it. You don't need to have it mapped to all platforms yet. [Example of such a PR](https://github.com/r-hub/sysreqsdb/pull/46).

* You can also make a pull request to add a mapping to a platform. [Example of such a PR](https://github.com/r-hub/sysreqsdb/pull/47).

### Reporting your use case

* If you maintain a public platform/tool using sysreqsdb, make a PR to this repo updating the [section below](#use-cases-of-the-database). Please put your tool at the very end of the list.

## Use cases of the database

* [R-hub](https://builder.r-hub.io/)

* The [`codemetar` package](https://github.com/ropensci/codemetar), R package for the [CodeMeta project](https://codemeta.github.io/), uses the sysreqs API to parse the SystemRequirements field.

## License

MIT © The R Consortium
