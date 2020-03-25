# Welcome to the Pagination Module

This module builds the pagination struct for API responses and custom data tables.

## LICENSE

Apache License, Version 2.0.


## SYSTEM REQUIREMENTS

- Adobe ColdFusion 2016+
- Lucee 4.5 or later

## Instructions

Just drop into your modules folder or use the `box` cli to install

```bash
box install cbpaginator
```


## Usage

This module provides two functions to build your pagination struct:

### generate

```js
public struct function generate(
    numeric totalRecords = 0,
    numeric page = 1,
    numeric maxRows = 25
)
```

Returns the pagination struct according to the total records.

If `page` and `maxRows` parameters are not passed in, it will use the default values.

The response will look like the following:

```js
{
    "totalPages": 0,
    "maxRows": 25,
    "offset": 0,
    "page": 1,
    "totalRecords": 0
}
```

### generateWithResults

```js
public struct function generateWithResults(
    numeric totalRecords = 0,
    array results = [],
    numeric page = 1,
    numeric maxRows = settings.defaults.maxRows,
    boolean asResultsMap = false,
    string keyName = "id",
    string resultsKeyName = "results"
)
```

This function returns the same pagination struct as the above along with the results

You can convert your results to be a resultsMap by setting `asResultsMap` to `true`

In addition you can set a name for your results key by passing in the `resultsKeyName` value as a parameter. By default this key is called `results`

```js
{
    "pagination": {
        "totalPages": 0,
        "maxRows": 25,
        "offset": 0,
        "page": 1,
        "totalRecords": 0
    },
    "results": [],
    // optional
    "resultsMap": {}
}
```


#### HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

> "Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD

 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12
