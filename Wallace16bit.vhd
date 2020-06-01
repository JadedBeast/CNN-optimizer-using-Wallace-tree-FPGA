library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;



entity wallace16 is
	Port ( A16 : in  STD_LOGIC_VECTOR (15 downto 0);
           B16 : in  STD_LOGIC_VECTOR (15 downto 0);
           prod16 : out  STD_LOGIC_VECTOR (31 downto 0));
end wallace16;

architecture Behavioral of wallace16 is
component wallace8 is
	Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           prod : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

signal mLow , mHigh , nLow, nHigh: STD_LOGIC_VECTOR (7 downto 0);
signal mLow_nLow ,mHigh_nLow ,mLow_nHigh ,mHigh_nHigh :STD_LOGIC_VECTOR (15 downto 0);
signal first,second,third,fourth,answer : integer;

begin
mLow <= A16(7 downto 0);
mHigh <= A16(15 downto 8);
nLow <= B16(7 downto 0);
nHigh <= B16(15 downto 8);
----Wallace8 multiplication 
y00 :wallace8 port map(mLow,nLow,mLow_nLow);
y01 :wallace8 port map (mHigh,nLow,mHigh_nLow);
y02 : wallace8 port map (mLow,nHigh,mLow_nHigh);
y03 : wallace8 port map (mHigh,nHigh,mHigh_nHigh);

first <= to_integer(unsigned(mLow_nLow));
second <= to_integer(unsigned(mHigh_nLow));
third <= to_integer(unsigned(mLow_nHigh));
fourth <= to_integer(unsigned(mHigh_nHigh));

answer <= first+(second+third)*256+fourth*65536;

prod16 <=std_logic_vector(to_signed(answer,32));

end Behavioral;

