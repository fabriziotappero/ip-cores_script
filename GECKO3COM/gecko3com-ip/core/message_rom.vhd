-- This file was generated with hex2rom written by Daniel Wallner

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity message_rom is
	port(
		A	: in std_logic_vector(4 downto 0);
		D	: out std_logic_vector(15 downto 0)
	);
end message_rom;

architecture rtl of message_rom is
	subtype ROM_WORD is std_logic_vector(15 downto 0);
	type ROM_TABLE is array(0 to 31) of ROM_WORD;
	signal ROM: ROM_TABLE := ROM_TABLE'(
                "0000000000000000",	-- 0x0000
		"0000001000000010",	-- 0x0000
		"0000000011111101",	-- 0x0002
		"0000000000100001",	-- 0x0004
		"0000000000000000",	-- 0x0006
		"0000000000000001",	-- 0x0008
		"0000000000000000",	-- 0x000A
		"0110100101001101",	-- 0x000C
		"0111001001100011",	-- 0x000E
		"0100110001101111",	-- 0x0010
		"0110001001100001",	-- 0x0012
		"0100001000100000",	-- 0x0014
		"0100100001000110",	-- 0x0016
		"0101010000101101",	-- 0x0018
		"0010110001001001",	-- 0x001A
		"0100010101000111",	-- 0x001C
		"0100101101000011",	-- 0x001E
		"0011001101001111",	-- 0x0020
		"0100111101000011",	-- 0x0022
		"0010110001001101",	-- 0x0024
		"0011100100110001",	-- 0x0026
		"0011000000101100",	-- 0x0028
		"0011001100101110",	-- 0x002A
		"0000000000001010",	-- 0x002C
		"----------------",	-- 0x002E
		"----------------",	-- 0x0030
		"----------------",	-- 0x0032
		"----------------",	-- 0x0034
		"----------------",	-- 0x0036
		"----------------",	-- 0x0038
		"----------------",	-- 0x003A
		"----------------");	-- 0x003C
begin
	D <= ROM(to_integer(unsigned(A)));
end;