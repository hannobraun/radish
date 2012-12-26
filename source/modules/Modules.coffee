window.def = ( moduleName, dependencyNames, moduleFactory ) ->
	window.modules = {} unless window.modules?

	unless window.modules[ moduleName ]?
		window.modules[ moduleName ] =
			name           : moduleName
			dependencyNames: dependencyNames
			factory        : moduleFactory
	else
		throw "Module " +moduleName+ " is already defined."

window.load = ( moduleName, loadedModules ) ->
	unless window.modules?
		throw "No modules have been defined."

	unless window.modules[ moduleName ]?
		throw "A module called " +moduleName+ " does not exist."

	loadedModules = {} unless loadedModules?

	unless loadedModules[ moduleName ]?
		module = window.modules[ moduleName ]

		dependencies = {}
		for dependencyName in module.dependencyNames
			unless modules[ dependencyName ]?
				throw
					"A module called \"#{ dependencyName }\" (defined as a " +
					"dependency in \"#{ moduleName }\") does not exist."
			
			dependencies[ dependencyName ] =
				load( dependencyName, loadedModules )

		loadedModules[ moduleName ] =
			module.factory( dependencies )
	
	loadedModules[ moduleName ]
