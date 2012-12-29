def "ToolUtils", [], ( m ) ->
	fs = require( "fs" )

	module =
		findModules: ( directory, modules ) ->
			files = fs.readdirSync( directory )

			for file in files
				path = directory+ '/' +file

				stats = fs.statSync( path )
				if stats.isDirectory()
					findModules( path, modules )
				else
					module = file.substring( 0, file.lastIndexOf( '.' ) )
					modules.push( module )
