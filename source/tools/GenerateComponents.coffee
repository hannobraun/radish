def 'GenerateComponents', [ 'RenderTemplate', 'ToolUtils' ], ( m ) ->
	fs = require( 'fs' )

	module =
		generate: () ->
			modules = []
			m.ToolUtils.findModules( 'source/code/game/components', modules )

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
