%remove dup and vline and triangle side distinct
diode(Image,Diode):-
	has_hline(Image,HLine1),
	has_triangle(Image,Triangle),
	has_vline(Image,VLine),
	has_hline(Image,HLine2),
	is_distinct_line(HLine1,HLine2),
	is_connected_tri_line(HLine1,Triangle),
	is_connected_tri_line(VLine,Triangle),
	%is_distinct_tri_line(VLine,Triangle),
	is_connected_line(VLine,HLine2),
	Diode = [HLine1,Triangle,VLine,HLine2].

epsilon_point(5.0).
point_approx_equal([X1,Y1],[X2,Y2]):-
	EucDist is sqrt((X1-X2)^2 + (Y1-Y2)^2),
	epsilon_point(Epsilon),
	EucDist =< Epsilon.

delta_line(0.000001).

is_distinct_line([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2]):-

	delta_line(DeltaLine),
	abs(X1-P1) >= DeltaLine,!.
is_distinct_line([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2]):-

	delta_line(DeltaLine),
	abs(X2-P2) >= DeltaLine,!.

is_distinct_line([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2]):-

	delta_line(DeltaLine),
	abs(Y1-Q1) >= DeltaLine,!.

is_distinct_line([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2]):-

	delta_line(DeltaLine),
	abs(Y2-Q2) >= DeltaLine,!.
	
	
	
is_connected_line([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2]):-
	
	point_approx_equal([X1,Y1],[P1,Q1]),!;
	point_approx_equal([X1,Y1],[P2,Q2]),!;
	point_approx_equal([X2,Y2],[P1,Q1]),!;
	point_approx_equal([X2,Y2],[P2,Q2]),!;	
	point_approx_equal([X1,Y1],[(P1+P2)/2,(Q1+Q2)/2]),!;
	point_approx_equal([X2,Y2],[(P1+P2)/2,(Q1+Q2)/2]),!;
	point_approx_equal([P1,Q1],[(X1+X2)/2,(Y1+Y2)/2]),!;
	point_approx_equal([P2,Q2],[(X1+X2)/2,(Y1+Y2)/2]),!.

is_connected_tri_line([X1,Y1]-[X2,Y2],[A1-B1,B2-C1,C2-A2]):-
	is_connected_line([X1,Y1]-[X2,Y2],A1-B1);
	is_connected_line([X1,Y1]-[X2,Y2],B2-C1);
	is_connected_line([X1,Y1]-[X2,Y2],C2-A2).
	

has_triangle(Image,Triangle):-
	has_line(Image,A1-B1),
	has_line(Image,B2-C1),
	approx_equal(A1-B1,B2-C1,B),
	has_line(Image,C2-A2),
	approx_equal(B2-C1,C2-A2,C),
	approx_equal(A1-B1,C2-A2,A),
	ordering(A1,B2,C2),
	Triangle = [A1-B1,B2-C1,C2-A2].

epsilon(3.0).
delta(0.000001).

ordering([X1,Y1],[X2,Y2],[X3,Y3]):-
	X1 =< X2,
	X2 =< X3.

approx_equal([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2],[X,Y]):-
	EucDist is sqrt((X1-P1)^2 + (Y1-Q1)^2),
	epsilon(Epsilon),
	delta(Delta),
	EucDist =< Epsilon,
	EucDist >= Delta,	
	X is (X1+P1)/2,
	Y is (Y1+Q1)/2.

approx_equal([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2],[X,Y]):-
	EucDist is sqrt((X1-P2)^2 + (Y1-Q2)^2),
	epsilon(Epsilon),
	delta(Delta),
	EucDist =< Epsilon,
	EucDist >= Delta,	
	X is (X1+P2)/2,
	Y is (Y1+Q2)/2.

approx_equal([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2],[X,Y]):-
	EucDist is sqrt((X2-P1)^2 + (Y2-Q1)^2),
	epsilon(Epsilon),
	delta(Delta),
	EucDist =< Epsilon,
	EucDist >= Delta,
	X is (X2+P1)/2,
	Y is (Y2+Q1)/2.

approx_equal([X1,Y1]-[X2,Y2],[P1,Q1]-[P2,Q2],[X,Y]):-
	EucDist is sqrt((X2-P2)^2 + (Y2-Q2)^2),
	epsilon(Epsilon),
	delta(Delta),	
	EucDist =< Epsilon,
	EucDist >= Delta,	
	X is (X2+P2)/2,
	Y is (Y2+Q2)/2.

is_distinct_tri_line([X1,Y1]-[X2,Y2],[A1-B1,B2-C1,C2-A2]):-
	is_distinct_line([X1,Y1]-[X2,Y2],A1-B1),
	is_distinct_line([X1,Y1]-[X2,Y2],B2-C1),
	is_distinct_line([X1,Y1]-[X2,Y2],C2-A2).

has_hline(Image,Hline):-
	line(Image,X1,Y1,X2,Y2,_,_,_),
	epsilon(Epsilon),
	Diff is abs(Y1 - Y2),
	Diff =< Epsilon,
	Hline = [X1,Y1]-[X2,Y2].
	
has_vline(Image,Vline):-
	line(Image,X1,Y1,X2,Y2,_,_,_),
	epsilon(Epsilon),
	Diff is abs(X1 - X2),
	Diff =< Epsilon,
	Vline = [X1,Y1]-[X2,Y2].
has_line(Image,[X1,Y1]-[X2,Y2]):-
	line(Image,X1,Y1,X2,Y2,_,_,_).



line(img1,40.733211,34.358104,41.060093,60.635137,2.499807,0.125000,21.595404).
line(img1,24.000706,9.375336,23.983916,53.125330,1.266310,0.125000,19.595805).
line(img1,41.000295,3.117732,40.792405,28.136778,2.489527,0.125000,25.838548).
line(img1,38.465805,31.157725,24.592352,7.480060,3.833830,0.125000,29.592747).
line(img1,24.815128,55.152086,38.653490,31.453684,3.592925,0.125000,31.760916).
line(img1,24.195223,0.729189,39.040475,26.344439,3.809822,0.125000,31.368997).
line(img1,1.853932,29.080760,21.887922,29.272115,3.905034,0.125000,30.752233).
line(img1,41.860098,29.282451,63.135226,29.046302,3.944003,0.125000,26.692565).
line(img1,38.684676,37.197069,23.916209,62.860986,3.679668,0.125000,31.237266).
line(img1,22.131335,63.120655,21.665360,35.628553,2.584376,0.125000,14.059217).
line(img1,21.664633,26.871163,22.143281,0.629894,2.590770,0.125000,13.045943).
line(img1,21.878440,33.758568,1.865455,33.867239,3.844969,0.125000,35.184326).
line(img1,63.148151,34.013540,40.598930,33.689581,3.983049,0.125000,36.947515).
line(img1,39.180846,23.126574,39.018633,3.117755,1.391828,0.125000,5.731120).
line(img1,38.949285,60.636477,39.245346,39.373195,1.476115,0.125000,4.530407).
