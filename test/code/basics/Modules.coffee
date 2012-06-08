describe "Modules", ->
	beforeEach ->
		delete window.modules
	
	it "should define a simple module without dependencies", ->
		moduleLoaded = false
		module "Module", [], ->
			moduleLoaded = true

		load( "Module" )

		expect( moduleLoaded ).to.equal( true )

	it "should pass a module's dependency into a module", ->
		dependencyModule = ""

		module "Dependency", [], ->
			"dependency"

		module "Module", [ "Dependency" ], ( Dependency ) ->
			dependencyModule = Dependency

		load( "Module" )

		expect( dependencyModule ).to.equal( "dependency" )

	it "should load every module only once", ->
		timesLoaded = 0

		module "Dependency", [], ->
			timesLoaded += 1

		module "ModuleA", [ "Dependency" ], ->

		module "ModuleB", [ "Dependency" ], ->

		module "MainModule", [ "ModuleA", "ModuleB" ], ->

		load( "MainModule" )

		expect( timesLoaded ).to.equal( 1 )

	it "should throw an error, if two modules are defined with the same id", ->
		module "Module", [], ->

		caughtError = try
			module "Module", [], ->
			false
		catch error
			true

		expect( caughtError ).to.equal( true )

	it "should throw a nice error message, if a a module is loaded that doesn't exist", ->
		module "Module", [], ->

		error = try
			load( "NonExistingModule" )
			undefined
		catch error
			error

		expect( error ).to.contain( "NonExistingModule" )

	it "should throw a nice error message, if a dependency does not exist", ->
		module "ExistingModule", [ "NonExistingModule" ], ->

		error = try
			load( "ExistingModule" )
			undefined
		catch error
			error

		expect( error ).to.contain( "ExistingModule" )
		expect( error ).to.contain( "NonExistingModule" )
