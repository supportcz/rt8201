PROGRAM _INIT
	
	RTInfo_0(enable := TRUE);
	
	samples := 20000/UDINT_TO_INT(RTInfo_0.cycle_time);
	
	//precompute SIN table
	twoPi := 2*3.1415926;
	
	FOR cycle := 0 TO samples-1 DO
		sinTable[cycle] := REAL_TO_INT(32000 * SIN(cycle*twoPi/samples));
	END_FOR	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	//50Hz generator
	cycle := cycle + 1;
	IF cycle >= samples THEN
		cycle := 0;
	END_IF
	
	sin_val := sinTable[cycle];
	
	sin_val_dint := sin_val;
	
END_PROGRAM
