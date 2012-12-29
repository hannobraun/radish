def 'RenderTemplate', [], ( m ) ->
	fs       = require( 'fs' )
	mustache = require( 'mustache' )

	( templateFileName, fileName, view ) ->
		directory = fileName.substring( 0, fileName.lastIndexOf( '/' ) )

		template = fs.readFileSync( templateFileName, 'utf8' )
		output   = mustache.render( template, view )

		unless fs.existsSync( directory )
			fs.mkdirSync( directory )

		fs.writeFileSync( fileName, output )
