component extends="testbox.system.BaseSpec" {

	function run() {
		describe( "paginator", function() {
            describe( "generate", function() {
                it( "it can generate pagination with defaults", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var result = paginator.generate( 100 );
                    expect( result ).toBe( {
                        "maxRows": 25,
                        "offset": 0,
                        "page": 1,
                        "totalPages": 4,
                        "totalRecords": 100
                    } );
                } );

                it( "can generate pagination for a different page", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var result = paginator.generate( 100, 2 );
                    expect( result ).toBe( {
                        "maxRows": 25,
                        "offset": 25,
                        "page": 2,
                        "totalPages": 4,
                        "totalRecords": 100
                    } );
                } );

                it( "can generate pagination with a custom maxRows", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var result = paginator.generate( 100, 2, 10 );
                    expect( result ).toBe( {
                        "maxRows": 10,
                        "offset": 10,
                        "page": 2,
                        "totalPages": 10,
                        "totalRecords": 100
                    } );
                } );
            } );

            describe( "generateWithResults", function() {
                it( "it can generate pagination with defaults", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var mockResults = [ { "id": 1 }, { "id": 2 }, { "id": 3 } ];
                    var result = paginator.generateWithResults( 100, mockResults );
                    expect( result ).toBe( {
                        "pagination": {
                            "maxRows": 25,
                            "offset": 0,
                            "page": 1,
                            "totalPages": 4,
                            "totalRecords": 100
                        },
                        "results": mockResults
                    } );
                } );

                it( "can generate pagination for a different page", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var mockResults = [ { "id": 1 }, { "id": 2 }, { "id": 3 } ];
                    var result = paginator.generateWithResults( 100, mockResults, 2 );
                    expect( result ).toBe( {
                        "pagination": {
                            "maxRows": 25,
                            "offset": 25,
                            "page": 2,
                            "totalPages": 4,
                            "totalRecords": 100
                        },
                        "results": mockResults
                    } );
                } );

                it( "can generate pagination with a custom maxRows", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var mockResults = [ { "id": 1 }, { "id": 2 }, { "id": 3 } ];
                    var result = paginator.generateWithResults( 100, mockResults, 2, 10 );
                    expect( result ).toBe( {
                        "pagination": {
                            "maxRows": 10,
                            "offset": 10,
                            "page": 2,
                            "totalPages": 10,
                            "totalRecords": 100
                        },
                        "results": mockResults
                    } );
                } );

                it( "can create a results map instead of an array for results", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var mockResults = [ { "id": 1 }, { "id": 2 }, { "id": 3 } ];
                    var result = paginator.generateWithResults( 100, mockResults, 3, 25, true );
                    expect( result ).toBe( {
                        "pagination": {
                            "maxRows": 25,
                            "offset": 50,
                            "page": 3,
                            "totalPages": 4,
                            "totalRecords": 100
                        },
                        "results": [ 1, 2, 3 ],
                        "resultsMap": { "1": { "id": 1 }, "2": { "id": 2 }, "3": { "id": 3 } }
                    } );
                } );

                it( "can use a custom keyName when generating the resultsMap", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var mockResults = [ { "myId": 1 }, { "myId": 2 }, { "myId": 3 } ];
                    var result = paginator.generateWithResults( 100, mockResults, 3, 25, true, "myId" );
                    expect( result ).toBe( {
                        "pagination": {
                            "maxRows": 25,
                            "offset": 50,
                            "page": 3,
                            "totalPages": 4,
                            "totalRecords": 100
                        },
                        "results": [ 1, 2, 3 ],
                        "resultsMap": { "1": { "myId": 1 }, "2": { "myId": 2 }, "3": { "myId": 3 } }
                    } );
                } );

                it( "can use a resultsKeyName when generating the resultsMap", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var mockResults = [ { "myId": 1 }, { "myId": 2 }, { "myId": 3 } ];
                    var result = paginator.generateWithResults( 100, mockResults, 3, 25, true, "myId", "stuff" );
                    expect( result ).toBe( {
                        "pagination": {
                            "maxRows": 25,
                            "offset": 50,
                            "page": 3,
                            "totalPages": 4,
                            "totalRecords": 100
                        },
                        "stuff": [ 1, 2, 3 ],
                        "stuffMap": { "1": { "myId": 1 }, "2": { "myId": 2 }, "3": { "myId": 3 } }
                    } );
                } );

                it( "can call getters when generating the resultsMap", function() {
                    var settings = getSettings();
                    var paginator = createMock( "models.Pagination" );
                    paginator.$property( propertyName = "settings", mock = settings );
                    var mockResults = [ { "getId": function() { return 1; } }, { "getId": function() { return 2; } }, { "getId": function() { return 3; } } ];
                    var result = paginator.generateWithResults( 100, mockResults, 3, 25, true );
                    expect( result.pagination ).toBe( {
                        "maxRows": 25,
                        "offset": 50,
                        "page": 3,
                        "totalPages": 4,
                        "totalRecords": 100
                    } );
                    expect( result.results ).toBe( [ 1, 2, 3 ] );
                } );
            } );
		} );
    }

    private struct function getSettings() {
        return {
			"defaults": {
				"maxRows": 25,
				"maxRowsLimit": 200
			},
			"apiPagination": {
				"maxRows": 15,
				"maxRowsLimit": 200
			},
			"elasticSearch": {
				"maxRows": 50,
				"maxRowsLimit": 200
			},
			"customPagination": {
				"maxRows": 5,
				"maxRowsLimit": 100
			}
		};
    }

}
