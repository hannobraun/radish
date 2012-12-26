def 'RenderTemplate', [], ( m ) ->
	fs       = require( 'fs' )
	mustache = require( 'mustache' )

	( templateFileName, fileName, view ) ->
		template = fs.readFileSync( templateFileName, 'utf8' )
		output   = mustache.render( template, view )
		fs.writeFileSync( fileName, output )
