def "Vec2Test", [ "Vec2" ], ( m ) ->
	describe "Vec2", ->
		it "should copy an existing vector", ->
			v1 = [ 0, 0 ]
			v2 = m.Vec2.copy( v1 )
			v1[ 0 ] = 1

			expect( v2 ).to.eql( [ 0, 0 ] )

		it "should overwrite an existing vector", ->
			v1 = [ 0, 0 ]
			v2 = [ 1, 2 ]

			m.Vec2.overwrite( v1, v2 )

			expect( v1 ).to.eql( v2 )

		it "should compare two vectors", ->
			v = [ 1, 2 ]

			expect( m.Vec2.equals( v, [ 1, 2 ] ) ).to.equal( true  )
			expect( m.Vec2.equals( v, [ 1, 3 ] ) ).to.equal( false )

		it "should scale a vector", ->
			v = [ 1, -1 ]

			m.Vec2.scale( v, 2 )

			expect( v ).to.eql( [ 2, -2 ] )

		it "should add two vectors", ->
			v1 = [ 1, -1 ]
			v2 = [ 1,  1 ]

			m.Vec2.add( v1, v2 )

			expect( v1 ).to.eql( [ 2, 0 ] )

		it "should subtract two vectors", ->
			v1 = [ 1, -1 ]
			v2 = [ 1,  1 ]

			m.Vec2.subtract( v1, v2 )

			expect( v1 ).to.eql( [ 0, -2 ] )

		it "should compute the dot product of two vectors", ->
			v1 = [ 2, 3 ]
			v2 = [ 3, 4 ]

			dotProduct = m.Vec2.dot( v1, v2 )

			expect( dotProduct ).to.equal( 18 )

		it "should compute the perp-dot product of two vectors", ->
			v1 = [ 2, 0 ]
			v2 = [ 0, 3 ]

			perpDotProduct = m.Vec2.perpDot( v1, v2 )

			expect( perpDotProduct ).to.equal( 6 )

		it "should return the vector's length", ->
			v = [ 2, 2 ]

			length = m.Vec2.length( v )

			tolerance = 0.001
			expect( length ).to.be.within(
				Math.sqrt( 8 ) - tolerance,
				Math.sqrt( 8 ) + tolerance  )

		it "should return the vector's squared length", ->
			v = [ 2, 2 ]

			squaredLength = m.Vec2.squaredLength( v )

			expect( squaredLength ).to.equal( 8 )

		it "should create a unit vector from a vector", ->
			v = [ 2, 0 ]

			m.Vec2.normalize( v )

			expect( v ).to.eql( [ 1, 0 ] )

		it "should rotate a vector 90 degrees counter-clockwise", ->
			v = [ 1, 1 ]

			m.Vec2.perp( v )

			expect( v ).to.eql( [ -1, 1 ] )

		it "should apply an affine transformation to the vector", ->
			v = [ 1, 0 ]
			t = [
				[ 0, 1, 0 ]
				[ 1, 0, 0 ]
				[ 0, 0, 1 ] ]

			m.Vec2.applyTransform( v, t )

			expect( v ).to.eql( [ 0, 1 ] )

load( "Vec2Test" )
