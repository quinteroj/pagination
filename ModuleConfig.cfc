/**
 * Pagination Module
 * ---
 */
component {

	// Module Properties
	this.title 				= "Pagination";
	this.author 			= "Javier Quintero";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "This module builds the pagination struct for API responses and custom data tables.";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	// URL Entry Point
	this.entryPoint			= "pagination";
	// Model Namespace
	this.modelNamespace 	= "pagination";
	// CF Mapping
	this.cfmapping 			= "pagination";
	this.dependencies 		= [ ];

	/**
	* Configure Module
	*/
	function configure(){

		// pagination settings
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

	}

	/**
	* Development tier
	*/
	function development(){
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