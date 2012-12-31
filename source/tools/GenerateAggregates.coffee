def "GenerateAggregates", [ "RenderTemplate" ], ( m ) ->
	fs = require( "fs" )

	directory =
		"components": "components"
		"entities"  : "entities"
		"systems"   : "systems"
	templateFile =
		"components": "Components.coffee.mustache"
		"entities"  : "Entities.coffee.mustache"
		"systems"   : "Systems.coffee.mustache"
	moduleFile =
		"components": "Components.coffee"
		"entities"  : "Entities.coffee"
		"systems"   : "Systems.coffee"

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
				"source/templates/aggregates/" +templateFile[ type ],
				"output/generated/" +moduleFile[ type ],
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
