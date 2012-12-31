def "Rm", [ "Paths" ], ( m ) ->
	fs = require( "fs" )

	module =
		rm: ( type, name ) ->
			directory =
				m.Paths[ "game-code" ] + m.Paths[ "game-directories" ][ type ]
			fileName =
				m.Paths.fileName( type, name )

			fs.unlinkSync( directory + fileName )
