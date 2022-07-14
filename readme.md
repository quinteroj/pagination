# Welcome to the Pagination Module

This module builds the pagination struct for API responses and custom data tables.

## LICENSE

Apache License, Version 2.0.


## SYSTEM REQUIREMENTS

- Adobe ColdFusion 2016+
- Lucee 4.5 or later

## REPOSITORY

The official repository for the [cbPaginator](https://forgebox.io/view/cbpaginator) module can be found [here](https://github.com/quinteroj/pagination).

## Instructions

Just drop into your modules folder or use the `box` cli to install

```bash
box install cbpaginator
```


## Usage

First you will need to inject the paginator into your service/handler:

```js
property name="cbpaginator" inject="Pagination@cbpaginator";
```

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

### generateSimple

```js
public struct function generateSimple(
        required boolean hasMore,
        numeric page = 1,
        numeric maxRows = 25
    )
```

Generates a simple pagination struct with the following struct

```js
{ "hasMore" : boolean, "maxRows" : numeric, "offset" : numeric, "page" : numeric }
```

### generateSimpleWithResults

```js
public struct function generateSimpleWithResults(
        array results = [],
        numeric page = 1,
        numeric maxRows = 25,
        boolean asResultsMap = false,
        string keyName = "id",
        string resultsKeyName = "results"
    )
```

Generates a simple pagination struct with along with the results following struct

### reduceAndGenerate

```js
public struct function reduceAndGenerate( 
        required array results, 
        numeric page = 0, 
        maxRows = 25 
    )
```

Reduce and paginate an array to bring back only the records requested in the page. Very useful when we want to sort all the results first and then paginate them


## Helper Method

### getPageOffset

Since we have to calculate the offset before we filter our data we can use the `getPageOffset()` function to calculate that number for us

```js
	public function getPageOffset( 
        page = 1,
        maxRows = 25 
    )
```

This function receives two arguments. The `page` number and the `maxRows` to retrieve. If no params are passed in, the defaults will be used.


