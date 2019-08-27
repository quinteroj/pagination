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
box install pagination
```

## ColdBox settings

You can overwrite the defaults for your app.  This configuration goes in `/config/ColdBox.cfc` in `moduleSettings.pagination` like so:

 ```js
		moduleSettings = {
			"pagination" = {
				"defaults" = {
					"totalPages": 0,
					"maxRows": 25,
					"offset": 0,
					"page": 1,
					"totalRecords": 0
				},
				"maxRowsLimit" = 200
      }
    }
```

## Settings

Here is the complete settings that you get by default.

```js
		"pagination" = {
			"defaults" = {
				"totalPages": 0,
				"maxRows": 25,
				"offset": 0,
				"page": 1,
				"totalRecords": 0
			},
			"apiPagination" = {
				"totalPages": 0,
				"maxRows": 25,
				"offset": 0,
				"page": 1,
				"totalRecords": 0
			},
			"elasticSearch" = {
				"totalPages": 0,
				"maxRows": 25,
				"offset": 0,
				"page": 1,
				"totalRecords": 0
			},
			"customPagination" = {
				"totalPages": 0,
				"maxRows": 25,
				"offset": 0,
				"page": 1,
				"totalRecords": 0
			},
			"maxRowsLimit" = 200
		};
```

## Usage

This module provides two methos to build your pagination struct with the with the following struct:

```js
			"pagination" = {
				"totalPages": 0,
				"maxRows": 25,
				"offset": 0,
				"page": 1,
				"totalRecords": 0
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
