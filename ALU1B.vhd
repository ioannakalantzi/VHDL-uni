

library ieee;
use ieee.std_logic_1164.all;	

------AND------
		
Entity product is 
	port ( a , b : in std_logic;
			result	: out std_logic);
End product;

Architecture func of product is
	Begin 
		result<= a and b;
End func;

------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;	
		
------OR------		
		
Entity addition is 
	port ( a , b : in std_logic;
			result	: out std_logic);
End addition;

Architecture func of addition is
	Begin 
		result<= a or b;
End func;

------------------------------------------------

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

------FullAdder------

ENTITY fullAdd IS
	PORT (CarryIn, x, y : IN STD_LOGIC ;
			Sum, CarryOut : OUT STD_LOGIC ) ;
END fullAdd ;


ARCHITECTURE LogicFunc OF fullAdd IS
	BEGIN
		Sum <= (x AND (NOT y) AND (NOT CarryIn)) 
				OR ((NOT x) AND y AND (NOT CarryIn)) 
				OR ((NOT x) AND (NOT y) AND CarryIn)
				OR (x AND y AND CarryIn); 
		CarryOut <= (x AND y) OR (CarryIn AND x) OR (CarryIn AND y) ; 
END LogicFunc ;

------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;

------πολυπλεκτης 2 προς 1------

Entity mux2to1Binvert is 
	port ( b: in std_logic;
			Binvert : IN STD_LOGIC;
			result : out std_logic);
End mux2to1Binvert;

Architecture Behavior of mux2to1Binvert is 
	Begin 
		with Binvert select
			result <=  b when '0',
						not(b) when others;
End Behavior;

------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;

------πολυπλεκτης 2 προς 1------

Entity mux2to1Ainvert is 
	port ( a: in std_logic;
			Ainvert : IN STD_LOGIC;
			result : out std_logic);
End mux2to1Ainvert;

Architecture Behavior of mux2to1Ainvert is 
	Begin 
		with Ainvert select
			result <=  a when '0',
					not(a) when others;
End Behavior;

------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;	

------xor------
		
Entity xorfunc is 
	port ( x1 , x2 : in std_logic;
			result	: out std_logic);
End xorfunc;

Architecture func of xorfunc is
	Begin 
		result<=x1 xor x2;
End func;

------------------------------------------------


Library ieee;
Use ieee.std_logic_1164.all;


------πολυπλεκτης 4 προς 1------

Entity mux4to1 is 
	port ( w0 , w1 , w2 , w3 : in std_logic;
			operation : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			result : out std_logic);
End mux4to1;

Architecture Behavior of mux4to1 is 
	Begin 
		with operation select
			result <=  w0 when "00",
						w1 when "01",
						w2 when "10",
						w3 when others;
End Behavior;

------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------ALU 1 BIT with components------

Entity ALU1B is 
	port ( a , b , Ainvert, Binvert, CarryIn: in std_logic;
			operation :IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			CarryOut: out std_LOGIC;
			f: out std_logic);
End ALU1B;

architecture structural of ALU1B is

--component for mux4to1
component mux4to1 
	port (w0 , w1 , w2 , w3: in std_LOGIC; operation :IN STD_LOGIC_VECTOR(1 DOWNTO 0); result: out std_logic);
 end component;

--component for product
component product
	port (a, b: in std_logic; result: out std_logic);
 end component;
 
 --componet for addition
component addition
	port (a, b: in std_logic; result: out std_logic);
 end component;

 --component for fullAdd
component fullAdd
	port (CarryIn, x, y: in std_logic; Sum, CarryOut : OUT STD_LOGIC);
 end component;

 --component for mux2to1Binvert
component mux2to1Binvert
	port ( b, Binvert: in std_logic; result: out std_logic);
 end component;
 
 --component for mux2to1Ainvert
component mux2to1Ainvert
	port ( a, Ainvert: in std_logic; result: out std_logic);
 end component;

 --component xorfunc
component xorfunc
	port (x1, x2: in std_logic; result: out std_logic);
 end component;

 
 --all singal i need to create my alu_1_bit
 signal outAinvert , outBinvert , w0, w1, w2, w3: std_logic;
 
 
 begin
S0: mux2to1Ainvert port map (a , Ainvert, outAinvert ); 
S1: mux2to1Binvert port map (b , Binvert, outBinvert);
S2: product port map ( outAinvert , outBinvert, w0); 
S3: addition port map (outAinvert , outBinvert , w1);
S4: fullAdd port map (CarryIn , outAinvert , outBinvert , w2 , CarryOut);
S5: xorfunc port map (outAinvert , outBinvert, w3);
S6: mux4to1 port map(w0 ,w1 ,w2 ,w3 ,operation(1 downto 0) ,f);
end structural;