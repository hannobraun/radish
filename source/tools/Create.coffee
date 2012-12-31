def "Create", [ "Paths", "RenderTemplate" ], ( m ) ->
	fs = require( "fs" )

	templateName =
		"component": "ComponentModule"
		"entity"   : "EntityModule"
		"system"   : "SystemModule"

	module =
		renderTemplate: ( type, name, force ) ->
			moduleName = m.Paths.moduleName( type, name )
			fileName   = m.Paths.fileName( type, name )

			templateFileName =
				m.Paths[ "templates" ]+ "game-modules/" +templateName[ type ]+ ".coffee.mustache"
			fileName =
				m.Paths[ "game-code" ] + m.Paths[ "game-directories" ][ type ] + fileName
			view =
				name      : name
				moduleName: moduleName

			if fs.existsSync( fileName ) && !force
				console.log( "File " +fileName+ " already exists." )
				console.log( "Delete file or re-run with -f." )
				process.exit( 1 )

			m.RenderTemplate( templateFileName, fileName, view )
