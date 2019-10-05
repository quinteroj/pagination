component {

	this.title = "Paginator";
	this.author = "Javier Quintero";
	this.webURL  = "https://www.ortussolutions.com";
	this.description = "This module builds the pagination struct for API responses and custom data tables.";
	this.cfmapping = "cbpaginator";
	this.dependencies = [];

	function configure() {
		settings = {
			"defaults": {
				"maxRows": 25,
				"maxRowsLimit": 200
			}
		};
	}

}
