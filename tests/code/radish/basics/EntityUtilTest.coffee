def "EntityUtilTest", [ "EntityUtil" ], ( m ) ->
	describe "EntityUtil", ->
		describe "createEntity", ->
			it "should pass the creation arguments to the entity factory", ->
				args         = { a: "a", b: "b" }
				receivedArgs = undefined

				entities =
					create: ( type, args ) ->
						receivedArgs = args

				m.EntityUtil.createEntity( entities, {}, "myEntity", args )

				expect( receivedArgs ).to.eql( args )

			it "should sort the returned components into the appropriate containers", ->
				id = "myId"
				componentA = {}
				componentB = {}

				components = {}

				entities =
					create: ( type, args ) ->
						entity =
							id: id
							components:
								"componentA": componentA
								"componentB": componentB

				m.EntityUtil.createEntity( entities, components, "myEntity", {} )

				expect( components[ "componentA" ][ id ] ).to.be( componentA )
				expect( components[ "componentB" ][ id ] ).to.be( componentB )

			it "should return the id of the created entity", ->
				id = "myId"
				componentA = {}
				componentB = {}

				components = {}

				entities =
					create: ( type, args ) ->
						entity =
							id: id
							components:
								"componentA": componentA
								"componentB": componentB

				returnedId = m.EntityUtil.createEntity(
					entities,
					components,
					"myEntity",
					{} )

				expect( returnedId ).to.equal( id )

		describe "destroyEntity", ->
			it "should remove an entity from the component containers", ->
				gameState =
					"componentA":
						"a": {}
						"b": {}
					"componentB":
						"a": {}
						"c": {}

				m.EntityUtil.destroyEntity( gameState, "a" )

				expectedGameState =
					"componentA":
						"b": {}
					"componentB":
						"c": {}
				expect( gameState ).to.eql( expectedGameState )

load( "EntityUtilTest" )
