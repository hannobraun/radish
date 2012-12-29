def 'GenerateComponents', [ 'RenderTemplate', 'ToolUtils' ], ( m ) ->
	fs = require( 'fs' )

	module =
		generate: () ->
			modules = []
			m.ToolUtils.findModules( 'source/code/game/components', modules )
			dependencyString = m.ToolUtils.buildDependencyString( modules )

			view =
				componentModules: dependencyString

			m.RenderTemplate(
				'source/templates/Components.coffee.mustache',
				'output/generated/Components.coffee',
				view )
