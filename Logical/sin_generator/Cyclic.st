PROGRAM _INIT
	
	//precompute SIN table
	twoPi := 2*3.1415926;
	
	FOR cycle := 0 TO 9 DO
		sinTable[cycle] := REAL_TO_INT(32000 * SIN(cycle*twoPi/10));
	END_FOR	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	//50Hz generator
	cycle := cycle + 1;
	IF cycle > 9 THEN
		cycle := 0;
	END_IF
	
	sin_val := sinTable[cycle];
	
END_PROGRAM
