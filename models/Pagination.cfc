/**
 * Pagination CFC to help generate the paginated results needed for API responses and  data tables
 */
component singleton{

    property name="settings" inject="coldbox:moduleSettings:cbpaginator";


	/**
	 * Generate
	 *
	 * This function generates a pagination struct
	 *
	 * @totalRecords The total record count
     * @page page number (current page)
     * @maxRows Maximum number of rows displayed per page
     * @results struct -> { "totalPages" : numeric, "maxRows" : numeric, "offset" : numeric, "page" : numeric, "totalRecords": numeric }
	 */
    function generate( required totalRecords=0, page, maxRows ){

        // Prepare Response
        var pagination = {
                "totalPages"  : 0,
                "maxRows"     : 0,
                "offset"      : 0,
                "page"        : 1,
                "totalRecords": arguments.totalRecords
            };
        
        // Validate and set maxRows
        if( isNull( arguments.maxRows ) || !isNumeric( arguments.maxRows ) ){
            pagination[ "maxRows" ] = settings[ "defaults" ][ "maxRows" ];
        } else if( arguments.maxRows GT settings[ "defaults" ][ "maxRowsLimit" ] ){
            pagination[ "maxRows" ] = settings[ "defaults" ][ "maxRowsLimit" ];
        } else if( arguments.maxRows LT 1 ){
            pagination[ "maxRows" ] = 0;
        } else{
            pagination[ "maxRows" ] = ceiling( arguments.maxRows );
        }

        // Calculate total pages
        pagination[ "totalPages" ] = pagination[ "maxRows" ] != 0 ? ceiling( pagination[ "totalRecords" ] / pagination[ "maxRows" ] ) : 0;

        // Validate and set page number
        if( !isNumeric( arguments.page ) ){
            pagination[ "page" ] = 1;
        } else if( arguments.page > pagination[ "totalPages" ] ){
            pagination[ "page" ] = pagination[ "totalPages" ];
        } else if( arguments.page LT 1 ){
            pagination[ "page" ] = 1;
        } else {
            pagination[ "page" ] = ceiling( arguments.page );
        }

        pagination[ "offset" ] = ( pagination[ "page" ]-1 ) * pagination[ "maxRows" ];

        return pagination;
    }

    /**
	 * Generate With Results
	 *
	 * This function generates the pagination struct along with the results
     * @totalRecords The total record count
     * @results List with the results ta will be included in the response
     * @page page number (current page)
     * @maxRows Maximum number of rows displayed per page
     * @resultMap Flag to determine if we want a result map for the results
     * @resultsKeyName Results key name to associate to the response
     * @results struct -> { "pagination" : {}, "results" : "[] }
	 */
    function generateWithResults( 
            required totalRecords=0,
            required results,
            page,
            maxRows,
            resultMap=false,
            resultsKeyName="results" 
        ){

        var response = {
            "pagination" = {},
            "#arguments.resultsKeyName#" = []
        };

        response[ "pagination" ] = generate( arguments.page, arguments.maxRows, arguments.totalRecords );

        // Do we want a Result map?
        if( arguments.resultMap ){
            // This is in progress
            response[ arguments.resultsKeyName ] = arguments.results
                .reduce( function( accumulator, item ){
                    var id = invoke( arguments.item, "get#id#" );
                    arguments.accumulator.results.append( id );
                    arguments.accumulator.resultsMap[ id ] = item.getMemento( argumentCollection=args );
                    return arguments.accumulator;
                }, {
                    "results"         : [],
                    "resultsMap"     : {}
                } );
        }
        else{
            response[ arguments.resultsKeyName ] = arguments.results;
        }

        return response;
    }

}