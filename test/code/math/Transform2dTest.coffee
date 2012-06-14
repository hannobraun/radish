module "Transform2dTest", [ "Transform2d" ], ( m ) ->
	describe "Transform2d", ->
		it "should create a transformation matrix for translation", ->
			t = m.Transform2d.translationMatrix( [ 3, 4 ] )

			expect( t ).to.eql( [
				[ 1, 0, 3 ]
				[ 0, 1, 4 ]
				[ 0, 0, 1 ] ] )

		it "should create a transformation matrix for rotation", ->
			r = m.Transform2d.rotationMatrix( Math.PI / 2 )

			tolerance = 0.001

			expect( r[ 0 ][ 0 ] ).to.be.within(  0 - tolerance,  0 + tolerance )
			expect( r[ 0 ][ 1 ] ).to.be.within( -1 - tolerance, -1 + tolerance )
			expect( r[ 0 ][ 2 ] ).to.equal( 0 )
			expect( r[ 1 ][ 0 ] ).to.be.within(  1 - tolerance,  1 + tolerance )
			expect( r[ 1 ][ 1 ] ).to.be.within(  0 - tolerance,  0 + tolerance )
			expect( r[ 1 ][ 2 ] ).to.equal( 0 )
			expect( r[ 2 ] ).to.eql( [ 0, 0, 1 ] )

		it "should create a transformation matrix for scaling", ->
			s = m.Transform2d.scalingMatrix( 2 )

			expect( s ).to.eql( [
				[ 2, 0, 0 ]
				[ 0, 2, 0 ]
				[ 0, 0, 1 ] ] )

load( "Transform2dTest" )
