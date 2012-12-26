def 'GenerateImagePaths', [], ( m ) ->
	fs = require( 'fs' )

	module =
		generateImages: () ->
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
