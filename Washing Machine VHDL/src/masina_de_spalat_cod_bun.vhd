---------------------------------------------------------------------------------------------------
--
-- Title       : afisor_7segmente
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : afisor_7segmente.vhd
-- Generated   : Sat May 14 17:44:02 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {afisor_7segmente} architecture {afisor_7segmente}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity masina_de_spalat_cod_bun is	
	port(
	led1,led2,led3,led4,led5,led6,led7,led8,led9,led10,led11,led12,led13,led14,led15,led16:out std_logic;
	sel,temp30,temp40,temp60,temp90,rot800,rot1000,rot1200,prespalare,clatire_suplimentara,camasi,spalare_rapida,culori_inchise,rufe_murdare,antialergic,usa,pornire_progrram,clk : in std_logic;	
	vector_anozi: out std_logic_vector(3 downto 0);
	vector_catozi: out std_logic_vector(6 downto 0));
	end entity;


	 -- enter your statements here --

architecture masina_de_spalat_cod_bun of masina_de_spalat_cod_bun is
	
component debouncer is
	port(BTN:in std_logic;
		CLK:in std_logic;
		R:in std_logic;
		BTN_NOU:out std_logic);
end component debouncer; 

component afisor_7_segmente is
	port(clock:in std_logic; 
	timpUNITATI,timpZECI:in std_logic_vector(3 downto 0); 
	vectorANOZI:out std_logic_vector(3 downto 0); 
	vectorCATOZI: out std_logic_vector(6 downto 0)
	);
end component afisor_7_segmente;

--}} End of automatically maintained section


component mux_catozi is 
	port(sel2: in std_logic_vector (1 downto 0);
	timp_U1,timp_z1: in std_logic_vector(3 downto 0);
	iesire:out std_logic_vector(3 downto 0)
	);
end component mux_catozi;

component mux_anozi is
	port(sel1: in std_logic_vector(1 downto 0);
	anozi: out std_logic_vector(3 downto 0));
end component mux_anozi;

component decodificator_bcd is
	port(a1: in std_logic_vector (3 downto 0);
	catozi: out std_logic_vector(6 downto 0)
	);
end component  decodificator_bcd;

component numarator_16_biti is
	port( A2:in std_logic_vector(15 downto 0); 
	eneable2: in std_logic;
	clk2: in std_logic;
	pl2,reset2: in std_logic;
	tc2:out std_logic;  
	Q2:out std_logic_vector(15 downto 0)
	);
end component numarator_16_biti;

 component demultiplexor is	 
	port(SELECTARE_MOD: in std_logic;
	PRESTABILIT, MANUAL : OUT STD_LOGIC);
end component demultiplexor; 

component codificator_pre_memorie is 
	port(I1,I2,I3,I4,I5,enableCodificator: in std_logic;
	iesire : out std_logic_vector(3 downto 0));
end component  codificator_pre_memorie;

  component memorie_ROM is
	port(A_ROM: in std_logic_vector(3 downto 0);
	enable_memorie: in std_logic;
	D_ROM: out std_logic_vector(15 downto 0));
end component memorie_ROM; 

 component decodificator is
	port( Intrare : in  std_logic_vector(15 downto 0);
	TimpU1,TimpZ1 : out integer;
	CS1,PResp1,TEMP3,temp4,temp6,temp9,ROT80,rot100,rot120,lc,lsr,lci,lrm,la: out std_logic;
	ipr,isp,icl,ics,ice: out integer);
end component decodificator;

component codificator_pre_numarare is 
	port(numar : in integer;
	timp_biti: out std_logic_vector(3 downto 0));
end component codificator_pre_numarare;
							
 component numarator is
	port( A:in std_logic_vector(3 downto 0); 
	B:in std_logic_vector(3 downto 0);
	enable: in std_logic;
	clk: in std_logic;
	pl,reset: in std_logic;
	tc:out std_logic;  
	Q1:out std_logic_vector(3 downto 0);
	Q:out std_logic_vector(3 downto 0);
	deschidere_usa: out std_logic
	);
end component numarator;

component divizor_de_frecventa is
    Port ( clk_100: in std_logic;
	Y:out std_logic);
end component divizor_de_frecventa;

 component multiplexor_temperatura is
	port( T1,T2,T3,T4: in std_logic;
	TEMPERATURA: out INTEGER;
	enable_manual :in std_logic;
	LED1_MUX,LED2_MUX,LED3_MUX,LED4_MUX: OUT STD_LOGIC);
end component multiplexor_temperatura;

component multiplexor_rotatii2 is
	port( R1,R2,R3: in std_logic;
	enable_manual1 :in std_logic;
	LED1_800,LED2_1000,LED3_1200 : OUT STD_LOGIC);
end component multiplexor_rotatii2;
 
component UAL_calcul_timp is 
	port( CS,Presp : std_logic;
	TEMP : in integer;
	TIMPU,TIMPZ : out integer;
	iprm,ispm,iclm,icsm,icem: out integer
	);
end component UAL_calcul_timp; 

component codificator_timpi_countdown is
	port(timpi_numarare: in std_logic_vector(3 downto 0);
	timpi_numarare_zecimal:out integer);
end component codificator_timpi_countdown; 

component poarta_si_enable is
	port(x,y:in std_logic;
	z:out std_logic);
end component poarta_si_enable;


signal enablespalare: std_logic;
signal modPrestabilit,modManual:std_logic;
signal selectieROM: std_logic_vector(3 downto 0);
signal iesireMemorieROM: std_logic_vector(15 downto 0);
signal ledCSprestabilit,ledPRESPprestabilit,T30Prestabilit,T40Prestabilit,T60Prestabilit,T90Prestabilit,rot800Prestabilit,rot1000Prestabilit,rot1200Prestabilit,ledCamasi,ledSpalareRapida,ledCuloriInchise,ledRufeMurdare,ledAntialergic:std_logic;
signal timpUnitatiPrestabilit,timpZeciPrestabilit:integer;
signal timpUnitatiPrestabilitbinar,timpZeciPrestabilitbinar,iesire1_numarator_prestabilit,iesire2_numarator_prestabilit:std_logic_vector(3 downto 0);
signal led_spalare_prestabilit,led_usa_prestabilit:std_logic;
signal clk1secunda:std_logic;
signal vector_anozi_prestabilit:  std_logic_vector(3 downto 0);
signal vector_catozi_prestabilit: std_logic_vector(6 downto 0);
signal temperaturaManual,zeci_manual,unitati_manual,zeci_prestabilit,unitati_prestabilit: integer;
signal T30Manual,T40Manual,T60Manual,T90Manual,rot800Manual,rot1000Manual,rot1200Manual: std_logic;
signal timpUnitatiManual,timpZeciManual:integer; 
signal timpUnitatiManualbinar,timpZeciManualbinar,iesire1_numarator_manual,iesire2_numarator_manual:std_logic_vector(3 downto 0);
signal led_spalare_manual,led_usa_manual:std_logic;
signal vector_anozi_manual:  std_logic_vector(3 downto 0);
signal vector_catozi_manual: std_logic_vector(6 downto 0);
signal inceputPRESPp,inceputSPp,inceputCLp,inceputCSp,inceputCEp: integer;
signal inceputPRESPm,inceputSPm,inceputCLm,inceputCSm,inceputCEm:integer;
signal timp1234:integer;
begin
	 U0_enable:poarta_si_enable port map(pornire_progrram,usa,enablespalare);
	--mod prestabilit
	U1_demultiplexor:demultiplexor port map(sel,modPrestabilit,modManual);
	U2_codificator: codificator_pre_memorie port map(antialergic,rufe_murdare,culori_inchise,camasi,spalare_rapida,modPrestabilit,selectieROM);
	U3_memorie: memorie_ROM port map(selectieROM,modPrestabilit,iesireMemorieROM);
	U4_decodificatorMemorie: decodificator port map(iesireMemorieROM,timpUnitatiPrestabilit,timpZeciPrestabilit,ledCSprestabilit,ledPRESPprestabilit,T30Prestabilit,T40Prestabilit,T60Prestabilit,T90Prestabilit,rot800Prestabilit,rot1000Prestabilit,rot1200Prestabilit,ledCamasi,ledSpalareRapida,ledCuloriInchise,ledRufeMurdare,ledAntialergic,inceputPRESPp,inceputSPp,inceputCLp,inceputCSp,inceputCEp);
    U5_codificator_unitati_prestabilit_biti: codificator_pre_numarare port map(timpUnitatiPrestabilit,timpUnitatiPrestabilitbinar);
	U6_codificator_zeci_prestabilit_biti:codificator_pre_numarare port map(timpZeciPrestabilit,timpZeciPrestabilitbinar);
	U7_divizor_frecventa: divizor_de_frecventa port map (clk,clk1secunda);
	U8_numarator: numarator port map(timpUnitatiPrestabilitbinar,timpZeciPrestabilitbinar,enablespalare,clk1secunda,'0','0',led_spalare_prestabilit,iesire1_numarator_prestabilit,iesire2_numarator_prestabilit,led_usa_prestabilit);
	U19_codif_zeci:codificator_timpi_countdown port map(iesire1_numarator_prestabilit,zeci_prestabilit);
	U10_codif_unitati:codificator_timpi_countdown port map(iesire2_numarator_prestabilit,unitati_prestabilit);
	U11_afisor_7_seg_prest: afisor_7_segmente port map (clk,iesire1_numarator_prestabilit,iesire2_numarator_prestabilit,vector_anozi_prestabilit,vector_catozi_prestabilit);
   
	-- mod manual
	U10_mux_temp: multiplexor_temperatura port map(temp30,temp40,temp60,temp90,temperaturaManual,modManual); 
	U11_mux_rot: multiplexor_rotatii2 port map(rot800,rot1000,rot1200,rot800Manual,rot1000Manual,rot1200Manual);
	U12_UAL: UAL_calcul_timp port map(clatire_suplimentara,prespalare,temperaturaManual,timpUnitatiManual,timpZeciManual,inceputPRESPm,inceputSPm,inceputCLm,inceputCSm,inceputCEm);
	U13_codificator_unitati_manual_biti: codificator_pre_numarare port map(timpUnitatiManual,timpUnitatiManualbinar);
	U14_codificator_zeci_manual_biti:codificator_pre_numarare port map(timpZeciManual,timpZeciManualbinar);
	U15_numarator: numarator port map(timpUnitatiManualbinar,timpZeciManualbinar,enablespalare,clk1secunda,'0','0',led_spalare_manual,iesire1_numarator_manual,iesire2_numarator_manual,led_usa_manual);
	U15_codif_zeci:codificator_timpi_countdown port map(iesire1_numarator_manual,zeci_manual);
	U16_codif_unitati:codificator_timpi_countdown port map(iesire2_numarator_manual,unitati_manual);
	U16_afisor_7_seg_man: afisor_7_segmente port map (clk,iesire1_numarator_manual,iesire2_numarator_manual,vector_anozi_manual,vector_catozi_manual);
	
	process(clk,sel)
	variable timp:integer;
	begin
		
		if(sel='1')then
			timp:=10*zeci_prestabilit+unitati_prestabilit;
			timp1234<=timp;
			led1<= '1';
			led2<=antialergic;
			led3<=rufe_murdare;
			led4<=culori_inchise;
			led5<=camasi;
			led6<=spalare_rapida;
			led12<=led_usa_prestabilit;	
			vector_anozi<= vector_anozi_prestabilit;
			vector_catozi<=	vector_catozi_prestabilit;
			
			if(inceputPRESPp=timp)then
				led7<='1';
				led8<='0';
				led9<='0';
				led10<='0';
				led11<='0';
				led16<='0';
			end if;
			if(inceputSPp=timp) then
				led7<='0';
				led8<='1';
				led9<='0';
				led10<='0';
				led11<='0';
				led16<='0';
			end if;
			if(inceputCSp=timp)	then
				led7<='0';
				led8<='0';
				led9<='0';
				led10<='1';
				led11<='0';
				led16<='0';
			end if;	   
			if(inceputClp=timp) then
				led7<='0';
				led8<='0';
				led9<='1';
				led10<='0';
				led11<='0';
				led16<='0';
			end if;
			if(inceputCEp=timp)	then
				led7<='0';
				led8<='0';
				led9<='0';
				led10<='0';
				led11<='1';
				led16<='0';
			end if;
			if(timp=0) then
				led11<='0';
				led12<='0';
				led13<='0';
				led14<='0';
				led15<='0';
				led16<='1';
			end if;
		else
		if(sel='0') then
			timp:=10*zeci_manual+unitati_manual;
			timp1234<=timp;
			led1<='0';
			led2<=temp30; 
			led3<=temp40;
			led4<=temp60;
			led5<=temp90;
			led6<=rot800;
			led7<=rot1000;
			led8<=rot1200;
			led9<=prespalare;
			led10<=clatire_suplimentara;
			led16<=led_usa_manual;
			vector_anozi<= vector_anozi_manual;
			vector_catozi<=	vector_catozi_manual;
			if(inceputPRESPm=timp)then
				led11<='1';
				led12<='0';
				led13<='0';
				led14<='0';
				led15<='0';	
				led16<='0';
			end if;
			if(inceputSPm=timp) then
				led11<='0';
				led12<='1';
				led13<='0';
				led14<='0';
				led15<='0';
				led16<='0';
			end if;
			if(inceputCSm=timp)	then
				led11<='0';
				led12<='0';
				led13<='0';
				led14<='1';
				led15<='0';
				led16<='0';
			end if;	   
			if(inceputClm=timp) then
				led11<='0';
				led12<='0';
				led13<='1';
				led14<='0';
				led15<='0';
				led16<='0';
			end if;
			if(inceputCEm=timp)	then
				led11<='1';
				led12<='0';
				led13<='0';
				led14<='0';
				led15<='1';
				led16<='0';
			end if;
			if(timp=0) then
				led11<='0';
				led12<='0';
				led13<='0';
				led14<='0';
				led15<='0';
				led16<='1';
				end if;
			end if;
		end if;
			
		end process;
	
end architecture;