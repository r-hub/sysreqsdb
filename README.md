
# sysreqs

> SystemRequirements for R packages

## Planned formats, example

First, a mapping from R package `SystemRequirements` fields
to canonical software library names:

```json
{
    "libgmp": [
    	"gmp",
    	"GMP (GNU MP bignum library)",
    	"GMP (GNU MP bignum library from http://gmplib.org/)"
    ],
    "libxml2": [
    	"libxml2"
    ],
    "gnumake": [
    	"GNU make"
    ]
}		
```

Second, we need platform dependent mappings from canonical names
to whatever the given platforms need to install the software.
Here is an example for `libxml2`:


```json
{
    "libxml2": {
        "regex": "^libxml2",
        "platforms": {
            "Debian": "libxml2",
            "Ubuntu": "libxml2-dev",
            "OSX/brew": null,
            "Windows": {
                "name": "libxml",
	            "url": "ftp://ftp.zlatkovic.com/libxml/"
    		}
		}
	}
}
```

Another example for `libgmp`:

```json
{
    "libgmp": {
        "platforms": {
            "Debian": "libgmp3-dev",
            "Ubuntu": [{
    	        "Version": "12.04",
				"Package": "libgmp3-dev"
			}],
    		"OSX/brew": "gmp",
			"Windows": {
				"name": null,
				"url": "FIXME"
			}
		}
	}
}
```
