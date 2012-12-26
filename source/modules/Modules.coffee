g = if global?
	global
else
	window

g.def = ( moduleName, dependencyNames, moduleFactory ) ->
	g.modules = {} unless g.modules?

	unless g.modules[ moduleName ]?
		g.modules[ moduleName ] =
			name           : moduleName
			dependencyNames: dependencyNames
			factory        : moduleFactory
	else
		throw 'Module "' +moduleName+ '" is already defined.'

g.load = ( moduleName, loadedModules ) ->
	unless g.modules?
		throw 'No modules have been defined.'

	unless g.modules[ moduleName ]?
		throw 'A module called "' +moduleName+ '" does not exist.'

	loadedModules = {} unless loadedModules?

	unless loadedModules[ moduleName ]?
		module = g.modules[ moduleName ]

		dependencies = {}
		for dependencyName in module.dependencyNames
			unless modules[ dependencyName ]?
				throw
					'A module called "' +dependencyName+ '" (defined as a ' +
					'dependency in "' +moduleName+ '") does not exist.'
			
			dependencies[ dependencyName ] =
				load( dependencyName, loadedModules )

		loadedModules[ moduleName ] =
			module.factory( dependencies )
	
	loadedModules[ moduleName ]
