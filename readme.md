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

## ColdBox settings

You can overwrite the defaults for your app.  This configuration goes in `/config/ColdBox.cfc` in `moduleSettings.pagination` like so:

 ```js
		moduleSettings = {
			"cbpaginator" = {
				"defaults" = {
					"maxRows": 50,
					"maxRowsLimit" : 250
				}
			}
		}
```

## Settings

Here is the complete settings that you get by default.

```js
		settings = {
			"defaults" = {
				"maxRows": 25,
				"maxRowsLimit" = 200
			},
			"apiPagination" = {
				"maxRows": 15,
				"maxRowsLimit" = 200
			},
			"elasticSearch" = {
				"maxRows": 50,
				"maxRowsLimit" = 200
			},
			"customPagination" = {
				"maxRows": 5,
				"maxRowsLimit" = 100
			}
		};
```

## Usage

This module provides two functions to build your pagination struct:

1.	`generate( required totalRecords, page, maxRows )` -> returns the pagination struct according to the total records.

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

2.	`generateWithResults( required totalRecords, required results, page, maxRows, resultMap=false, resultsKeyName="results" )`

This function returns the same pagination struct as the above along with the results

You can convert your results to be a result Map by changing the default value of `resultsKeyName` to true

In addition you can set a name for your results key by passing in the `resultsKeyName` value as a parameter. By default this key is called `results`

```js
		{
			"pagination" = {
				"totalPages": 0,
				"maxRows": 25,
				"offset": 0,
				"page": 1,
				"totalRecords": 0
			},
			"results" = []
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
