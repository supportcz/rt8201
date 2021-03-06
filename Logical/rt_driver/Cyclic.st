PROGRAM _INIT
	 
	RTEnable := TRUE;
	pulseLength := 0.2; 
	
	//just variable declarations
	RTCycleCounter;
	RES01;//odpovedi z RT karty do PLC
	RES02;
	RES03;
	RES04;
	RES05;
	RES06;
	
	time1 := 2;//cas pred svarovanim
	time2 := 1;//cas po svarovani
	period1 := 3;//kolik period se vzrustajicim vykonem
	period2 := 7;//kolik period s konstantnim vykonem
	percent1 := 40;//pocatecni vykon
	percent2 := 54;//konecny vykon
	
	RTInfo_0(enable := TRUE);//pro zjisteni task class
	
END_PROGRAM

PROGRAM _CYCLIC
	
	//pulse counter
	periodCounter := RES02;//citac period
	
	CASE step OF
		0:
			percent := 0;

			//wait for start button
			IF cmdStart THEN
				usCounter := 0;
				step := step + 1;
			END_IF
		1:
			//wait time1
			usCounter := usCounter + RTInfo_0.cycle_time;
			IF usCounter > REAL_TO_UDINT(time1 * 1000000) THEN
				period := 0;
				step := step + 1;
			END_IF
	
		2:
			//increase power
			IF periodCounter <> oldPeriodCounter THEN
				percent := percent1 + period * (percent2 - percent1)/period1;
				period := period + 1;
				IF period > period1 THEN
					step := step + 1;
				END_IF
			END_IF
		
		3:
			//hold power
			IF periodCounter <> oldPeriodCounter THEN
				period := period + 1;
				IF period > period1 + period2 THEN
					percent := 0;
					usCounter := 0;
					step := step + 1;
				END_IF
			END_IF
			
		4:
			//wait time2
			usCounter := usCounter + RTInfo_0.cycle_time;
			IF usCounter > REAL_TO_UDINT(time2 * 1000000) THEN
				step := 0;
			END_IF
		
	END_CASE
	
	oldPeriodCounter := periodCounter;
	
	//send opening angle to thyristor
	PAR01 := REAL_TO_DINT(1000000 - 10000 * percent) + 1; //1 se p�i��ta aby fungoval rtiDoutTime
	IF PAR01 < 1 THEN
		PAR01 := 1;
	END_IF
	
	//send pulse length to thyristor
	PAR02 := REAL_TO_DINT(1000000 * pulseLength); 
	IF PAR02 < 0 OR PAR01 > 1000000 THEN
		PAR02 := 0;
	END_IF
	
END_PROGRAM
