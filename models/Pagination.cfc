/**
 * Pagination CFC to help generate the paginated results needed for API responses and  data tables
 */
component singleton accessors="true" {

    property name="settings" inject="coldbox:moduleSettings:cbpaginator";

    /**
     * Creates a new paginator
     * If using this in ColdBox, these settings will be overridden by WireBox
     */
    function init( struct settings = getDefaultSettings() ) {
        variables.settings = arguments.settings;
        return this;
    }

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
        numeric maxRows = settings.defaults.maxRows
    ) {
        var pagination = {};
        pagination[ "totalRecords" ] = arguments.totalRecords;
        pagination[ "maxRows" ] = clamp( 0, arguments.maxRows, settings.defaults.maxRowsLimit );
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
        numeric maxRows = settings.defaults.maxRows,
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

    private struct function getDefaultSettings() {
        return {
            "defaults": {
                "maxRows": 25,
                "maxRowsLimit": 200
            }
        };
    }

}
