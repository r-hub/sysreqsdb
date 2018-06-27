
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
ways. E.g. `igraph` has simply `libxml2` and `XML` has `libxml2 (>= 2.6.3)`
in their `SystemRequirements` fields.

```json
{
  "libxml2": {
    "sysreqs": "/libxml2/",
    "platforms": {
      "DEB": {
        "runtime": "libxml2",
        "buildtime": "libxml2-dev"
      },
      "OSX/brew": null,
      "RPM": "libxml2",
      "Windows": {
        "32bit": [
          "ftp://ftp.zlatkovic.com/libxml/zlib-1.2.5.win32.zip",
          "ftp://ftp.zlatkovic.com/libxml/iconv-1.9.2.win32.zip",
          "ftp://ftp.zlatkovic.com/libxml/libxml2-2.7.8.win32.zip",
        ],
        "64bit": [
          "ftp://ftp.zlatkovic.com/libxml/64bit/zlib-1.2.8-win32-x86_64.7z",
          "ftp://ftp.zlatkovic.com/libxml/64bit/iconv-1.14-win32-x86_64.7z",
          "ftp://ftp.zlatkovic.com/libxml/64bit/libxml2-2.9.3-win32-x86_64.7z"
        ]
      }
    }
  }
}
```

Some notes:
* The `sysreqs` field can be a list, and its entries can be regular
  expressions (when starting and ending with a forward slash).
* Not all platforms have the same information, For `DEB` based Linux
  flavours (Debian, Ubuntu, etc.) packages that can be installed via the
  host package manager are listed. For Windows, typically URLs that have
  to be downloaded and installed.
* `null` for `OSX/brew` means that nothing is needed, the system includes
  the requirement(s) by default.

## Database access

See API docs at <https://sysreqs.r-hub.io/>

## Contributing

### Adding or completing entries

### Reporting your use case

* If you maintain a public platform/tool using sysreqsdb, make a PR to this repo updating the [section below](#use-cases-of-the-database). Please put your tool at the very end of the list.

## Use cases of the database

* [R-hub](https://builder.r-hub.io/)

* The [`codemetar` package](https://github.com/ropensci/codemetar), R package for the [CodeMeta project](https://codemeta.github.io/), uses the sysreqs API to parse the SystemRequirements field

## License

MIT © The R Consortium
