def 'Create', [], ( m ) ->
	fs       = require( 'fs' )
	mustache = require( 'mustache' )

	templateName =
		'component': 'ComponentModule'
		'entity'   : 'EntityModule'
		'system'   : 'SystemModule'
	directory =
		'component': 'components'
		'entity'   : 'entities'
		'system'   : 'systems'
	moduleSuffix =
		'component': 'Component'
		'entity'   : 'Entity'
		'system'   : 'System'

	module =
		renderTemplate: ( type, name, force ) ->
			moduleName = name + moduleSuffix[ type ]

			template = fs.readFileSync(
				'source/templates/' +templateName[ type ]+ '.coffee.mustache',
				'utf8' )

			view =
				name      : name
				moduleName: moduleName

			output = mustache.render( template, view )

			fileName = 'source/code/game/' +directory[ type ]+ '/' +moduleName+ '.coffee'
			if fs.existsSync( fileName ) && !force
				console.log( 'File ' +fileName+ ' already exists.' )
				console.log( 'Delete file or re-run with -f.' )
				process.exit( 1 )

			fs.writeFileSync( fileName, output )
