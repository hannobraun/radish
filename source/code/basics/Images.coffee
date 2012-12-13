module "Images", [], ( m ) ->
	module =
		loadImages: ( imagePaths, onLoad ) ->
			images = {}

			numberOfImagesToLoad = imagePaths.length

			for imagePath in imagePaths
				image = new Image
				images[ imagePath ] = image

				image.onload = ->
					numberOfImagesToLoad -= 1
					if numberOfImagesToLoad == 0
						onLoad( images )

				image.src = imagePath

		process: ( rawImages ) ->
			images = {}

			for imagePath, rawImage of rawImages
				imageId = imagePath.substring( imagePath.indexOf( "/" ) + 1 )
				
				images[ imageId ] =
					rawImage: rawImage
					positionOffset: [ -rawImage.width / 2, -rawImage.height / 2]
					orientationOffset: 0

			images
