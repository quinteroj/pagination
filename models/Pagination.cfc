/**
 * Pagination CFC to help generate the paginated results needed for API responses and  data tables
 */
component singleton{

    property name="settings" inject="coldbox:moduleSettings:pagination";


	/**
	 * generatePagination
	 *
	 * This function generates a pagination struct
	 *
	 * @totalRecords The total record count
     * @page page number (current page)
     * @maxRows Maximum number of rows displayed per page
	 */
    function generatePagination( required totalRecords=0, page, maxRows ){

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
        } else if( arguments.maxRows GT settings[ "maxRowsLimit" ] ){
            pagination[ "maxRows" ] = settings[ "maxRowsLimit" ];
        }
        else{
            pagination[ "maxRows" ] = ceiling( arguments.maxRows );
        }

        // Calculate total pages
        pagination[ "totalPages" ] = pagination[ "maxRows" ] != 0 ? ceiling( pagination[ "totalRecords" ] / pagination[ "maxRows" ] ) : 0;

        // Validate and set page number
        if( !isNumeric( arguments.page ) ){
            pagination[ "page" ] = settings[ "defaults" ][ "page" ];
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
	 * generateResultsPagination
	 *
	 * This function generates a pagination struct
     * @totalRecords The total record count
     * @results List with the results ta will be included in the response
     * @page page number (current page)
     * @maxRows Maximum number of rows displayed per page
     * @resultMap Flag to determine if we want a result map for the results
     * @resultsKeyName Results key name to associate to the response
     * 
	 */
    function generateResultsPagination( required totalRecords=0, required results, page, maxRows, resultMap=false, resultsKeyName="results" ){

        var response = {
            "pagination" = {},
            "#arguments.resultsKeyName#" = []
        };

        response[ "pagination" ] = generatePagination( arguments.page, arguments.maxRows, arguments.totalRecords );

        // Do we want a Result map?
        if( arguments.resultMap ){
            var ids = [];
            var map = {};
            for ( var item in data ) {
                arrayAppend( ids, item[ key ] );
                map[ item[ key ] ] = item;
            }

            response[ arguments.resultsKeyName ] = {
                "results" = ids,
                "resultsMap" = map
            };
        }
        else{
            response[ arguments.resultsKeyName ] = arguments.results;
        }

        return response;
    }

}