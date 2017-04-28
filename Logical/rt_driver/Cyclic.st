PROGRAM _INIT
	 
	RTEnable := TRUE;
	pulseLength := 0.5; 
	
	//just variable declarations
	RTCycleCounter;
	RES01;
	RES02;
	RES03;
	
	time1 := 2;
	time2 := 1;
	period1 := 3;
	period2 := 7;
	percent1 := 40;
	percent2 := 54;
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//send opening angle to thyristor
	PAR01 := REAL_TO_DINT(1000 - 10 * percent);
	IF PAR01 < 1 THEN
		PAR01 := 1;
	END_IF
	
	//send pulse length to thyristor
	PAR02 := REAL_TO_DINT(100 * pulseLength); 
	IF PAR02 < 0 THEN
		PAR02 := 0;
	END_IF
	
END_PROGRAM
