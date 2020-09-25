/**
 * Pagination CFC to help generate the paginated results needed for API responses and  data tables
 */
component singleton accessors="true" {

    /**
     * Generates a pagination struct
     *
     * @totalRecords The total record count
     * @page page number (current page)
     * @maxRows Maximum number of rows displayed per page
     *
     * @returns struct -> { "totalPages" : numeric, "maxRows" : numeric, "offset" : numeric, "page" : numeric, "totalRecords": numeric }
     */
    public struct function generate(
        numeric totalRecords = 0,
        numeric page = 1,
        numeric maxRows = 25
    ) {
        var pagination = {};
        pagination[ "totalRecords" ] = arguments.totalRecords;
        pagination[ "maxRows" ] = max( 0, arguments.maxRows );
        pagination[ "totalPages" ] = pagination.maxRows != 0 ? ceiling( pagination.totalRecords / pagination.maxRows ) : 0;
        pagination[ "page" ] = clamp( 1, arguments.page, pagination.totalPages );
        pagination[ "offset" ] = ( pagination.page - 1 ) * pagination.maxRows;
        return pagination;
    }

    /**
     * Generates the pagination struct along with the results
     *
     * @totalRecords The total record count
     * @results List with the results ta will be included in the response
     * @page page number (current page)
     * @maxRows Maximum number of rows displayed per page
     * @resultMap Flag to determine if we want a result map for the results
     * @keyName Name of the key to find in each record for a results map
     * @resultsKeyName Results key name to associate to the response
     *
     * @returns struct -> { "pagination" : {}, "results" : "[] }
     */
    public struct function generateWithResults(
        numeric totalRecords = 0,
        array results = [],
        numeric page = 1,
        numeric maxRows = 25,
        boolean asResultsMap = false,
        string keyName = "id",
        string resultsKeyName = "results"
    ) {
        var response = {};
        response[ "pagination" ] = generate(
            arguments.totalRecords,
            arguments.page,
            arguments.maxRows
        );
        structAppend(
            response,
            arguments.asResultsMap ?
                generateResultsMap( arguments.results, arguments.keyName, arguments.resultsKeyName ) :
                { "#arguments.resultsKeyName#" = arguments.results }
        );
        return response;
    }

    private numeric function clamp( lowerLimit, result, upperLimit ) {
        arguments.result = ceiling( arguments.result );
        arguments.result = min( arguments.result, arguments.upperLimit );
        return max( arguments.lowerLimit, arguments.result );
    }

    private struct function generateResultsMap(
        required array results,
        string keyName = "id",
        string resultsKeyName = "results"
    ) {
        var resultsMapKeyName = arguments.resultsKeyName & "Map";
        return arguments.results.reduce( function( acc, item ) {
            var key = structKeyExists( item, "get#keyName#" ) ?
                invoke( item, "get#keyName#" ) :
                item[ keyName ];

            arrayAppend( acc[ resultsKeyName ], key );
            acc[ resultsMapKeyName ][ key ] = item;

            return acc;
        }, { "#resultsKeyName#" = [], "#resultsMapKeyName#" = {} } );
    }

    /******************************** HELPER FUNCTIONS ******************************/

    /**
	 * Calculate the starting offset for the incoming page
	 *
	 * @page The page to lookup on
     * @maxRows The max rows number so we can calculate the offset (defaults to 25)
	 * @param-page { "schema" : { "type" : "integer", "minimum" : 1, "default" : 1 } }
	 *
	 * @return The page start offset
	 */
	public function getPageOffset( page = 1, maxRows = 25 ){
		return ( arguments.page * arguments.maxRows - arguments.maxRows );
	}

}
