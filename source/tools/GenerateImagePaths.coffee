def "GenerateImagePaths", [ "Paths", "RenderTemplate" ], ( m ) ->
	fs = require( "fs" )

	module =
		generateImagePaths: () ->
			files = fs.readdirSync( "source/images" )
			imagePaths = ""
			for file in files
				imagePaths += '"images/' +file+ '", '

			view =
				imagePaths: imagePaths.substring( 0, imagePaths.length - 2 )


			m.RenderTemplate(
				m.Paths[ "templates" ]+ "ImagePaths.coffee.mustache",
				"output/generated/ImagePaths.coffee",
				view )
