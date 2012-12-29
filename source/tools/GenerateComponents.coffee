def 'GenerateComponents', [ 'RenderTemplate' ], ( m ) ->
	fs = require( 'fs' )

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

	module =
		generate: () ->
			modules = []
			findModules( 'source/code/game/components', modules )

			componentModules = '[ '
			for module in modules
				componentModules += "'" +module+ "', "
			componentModules =
				componentModules.substring( 0, componentModules.length - 2 )
			componentModules += ' ]'

			view =
				componentModules: componentModules

			m.RenderTemplate(
				'source/templates/Components.coffee.mustache',
				'output/generated/Components.coffee',
				view )
