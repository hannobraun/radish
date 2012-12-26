def 'Create', [], ( m ) ->
	fs       = require( 'fs' )
	mustache = require( 'mustache' )

	module =
		renderComponentTemplate: ( componentName, force ) ->
			template = fs.readFileSync(
				'source/templates/ComponentModule.coffee.mustache',
				'utf8' )

			view =
				name: componentName

			output = mustache.render( template, view )

			fileName = 'source/code/game/components/' +componentName+ 'Component.coffee'
			if fs.existsSync( fileName ) && !force
				console.log( 'File ' +fileName+ ' already exists.' )
				console.log( 'Delete file or re-run with -f.' )
				process.exit( 1 )

			fs.writeFileSync( fileName, output )
