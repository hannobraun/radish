def 'GenerateAggregates', [ 'RenderTemplate', 'ToolUtils' ], ( m ) ->
	fs = require( 'fs' )

	module =
		generate: () ->
			modules = []
			findModules( 'source/code/game/components', modules )
			dependencyString = m.ToolUtils.buildDependencyString( modules )

			view =
				componentModules: dependencyString

			m.RenderTemplate(
				'source/templates/Components.coffee.mustache',
				'output/generated/Components.coffee',
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
