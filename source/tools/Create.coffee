def "Create", [ "Paths", "RenderTemplate" ], ( m ) ->
	fs = require( "fs" )

	templateName =
		"component": "ComponentModule"
		"entity"   : "EntityModule"
		"system"   : "SystemModule"
	directory =
		"component": "components"
		"entity"   : "entities"
		"system"   : "systems"
	moduleSuffix =
		"component": "Component"
		"entity"   : "Entity"
		"system"   : "System"

	module =
		renderTemplate: ( type, name, force ) ->
			moduleName =
				name[ 0 ].toUpperCase() +
				name.substring( 1 ) +
				moduleSuffix[ type ]

			templateFileName =
				m.Paths[ "templates" ]+ "game-modules/" +templateName[ type ]+ ".coffee.mustache"
			fileName =
				"source/code/game/" +directory[ type ]+ "/" +moduleName+ ".coffee"
			view =
				name      : name
				moduleName: moduleName

			if fs.existsSync( fileName ) && !force
				console.log( "File " +fileName+ " already exists." )
				console.log( "Delete file or re-run with -f." )
				process.exit( 1 )

			m.RenderTemplate( templateFileName, fileName, view )
