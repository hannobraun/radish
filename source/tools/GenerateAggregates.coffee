def 'GenerateAggregates', [ 'RenderTemplate' ], ( m ) ->
	fs = require( 'fs' )

	directories =
		"components": "source/code/game/components"
	templateFiles =
		"components": "source/templates/Components.coffee.mustache"
	moduleFiles =
		"components": "output/generated/Components.coffee"

	module =
		generateAggregate: ( type ) ->
			modules = []
			findModules( directories[ type ], modules )
			dependencyString = buildDependencyString( modules )

			view =
				componentModules: dependencyString

			m.RenderTemplate(
				templateFiles[ type ],
				moduleFiles[ type ],
				view )

	findModules = ( directory, modules ) ->
		files = fs.readdirSync( directory )

		for file in files
			path = directory+ '/' +file

			stats = fs.statSync( path )
			if stats.isDirectory()
				findModules( path, modules )
			else
				module = file.substring( 0, file.lastIndexOf( '.' ) )
				modules.push( module )

	buildDependencyString = ( dependencies ) ->
		dependencyString = '[ '

		for module in dependencies
			dependencyString += "'" +module+ "', "
		dependencyString =
			dependencyString.substring( 0, dependencyString.length - 2 )

		dependencyString += ' ]'

	module
