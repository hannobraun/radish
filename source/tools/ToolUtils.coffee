def "ToolUtils", [], ( m ) ->
	fs = require( "fs" )

	module =
		buildDependencyString: ( dependencies ) ->
			dependencyString = '[ '

			for module in dependencies
				dependencyString += "'" +module+ "', "
			dependencyString =
				dependencyString.substring( 0, dependencyString.length - 2 )

			dependencyString += ' ]'
