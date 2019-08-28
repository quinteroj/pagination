/**
 * Pagination Module
 * ---
 */
component {

	// Module Properties
	this.title 				= "Paginator";
	this.author 			= "Javier Quintero";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "This module builds the pagination struct for API responses and custom data tables.";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	// URL Entry Point
	this.entryPoint			= "cbpaginator";
	// Model Namespace
	this.modelNamespace 	= "cbpaginator";
	// CF Mapping
	this.cfmapping 			= "cbpaginator";
	this.dependencies 		= [ ];

	/**
	* Configure Module
	*/
	function configure(){
		
		// settings
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

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}