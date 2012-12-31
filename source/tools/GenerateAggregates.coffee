def "GenerateAggregates", [ "RenderTemplate" ], ( m ) ->
	fs = require( "fs" )

	directory =
		"components": "components"
		"entities"  : "entities"
		"systems"   : "systems"
	templateFiles =
		"components": "source/templates/aggregates/Components.coffee.mustache"
		"entities"  : "source/templates/aggregates/Entities.coffee.mustache"
		"systems"   : "source/templates/aggregates/Systems.coffee.mustache"
	moduleFiles =
		"components": "output/generated/Components.coffee"
		"entities"  : "output/generated/Entities.coffee"
		"systems"   : "output/generated/Systems.coffee"

	module =
		generateAggregate: ( type ) ->
			modules = []
			findModules(
				"source/code/game/" +directory[ type ],
				modules )
			dependencyString = buildDependencyString( modules )

			view =
				"modules": dependencyString

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
		dependencyString = "[ "

		for module in dependencies
			dependencyString += '"' +module+ '", '
		dependencyString =
			dependencyString.substring( 0, dependencyString.length - 2 )

		dependencyString += " ]"

	module
