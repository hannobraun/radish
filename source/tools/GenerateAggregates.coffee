def "GenerateAggregates", [ "Paths", "RenderTemplate" ], ( m ) ->
	fs = require( "fs" )

	directory =
		"component": "components"
		"entity"   : "entities"
		"system"   : "systems"
	templateFile =
		"component": "Components.coffee.mustache"
		"entity"   : "Entities.coffee.mustache"
		"system"   : "Systems.coffee.mustache"
	moduleFile =
		"component": "Components.coffee"
		"entity"   : "Entities.coffee"
		"system"   : "Systems.coffee"

	module =
		generateAggregate: ( type ) ->
			modules = []
			findModules(
				m.Paths[ "game-code" ] + directory[ type ],
				modules )
			dependencyString = buildDependencyString( modules )

			view =
				"modules": dependencyString

			m.RenderTemplate(
				m.Paths[ "templates" ]+ "aggregates/" +templateFile[ type ],
				m.Paths[ "generated-code" ] + moduleFile[ type ],
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
