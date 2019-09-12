entity testbench is
end entity;

architecture mealy of testbench is
component doorpass is
    port(
        daytime: in bit;
        reset: in bit;
        code: in bit_vector(3 downto 0);
        vdd: in bit;
        vss: in bit;
        clk: in bit;
        door: out bit;
        alarm: out bit
    );
end component;

for dp : doorpass use entity work.doorpass(fsm);

signal clk : bit := '0';
signal reset : bit := '1';
signal daytime : bit := '0';
signal code : bit_vector(3 downto 0) := "0010";
signal vdd : bit := '1';
signal vss : bit := '0';
signal door : bit := '0';
signal alarm : bit := '0';

constant delay_time : time := 10 ns;

begin

dp : doorpass port map(daytime, reset, code, vdd, vss, clk, door, alarm);

process is
begin
    clk <= '1';
    wait for delay_time/2;
    clk <= '0';
    wait for delay_time/2;    
end process;

process is
begin
-- Test case 1: Enter full correct code at night, then press "O"
assert door = '0' and alarm = '0' 
report "Next state s0, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

reset <= '0';
assert door = '0' and alarm = '0'
report "Next state s1, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0110";
assert door = '0' and alarm = '0'
report "Next state s2, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1010";
assert door = '0' and alarm = '0'
report "Next state s3, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0000";
assert door = '0' and alarm = '0'
report "Next state s4, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0101";
assert door = '0' and alarm = '0'
report "Next state s5, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1101";
wait for 1 ns;
assert door = '1' and alarm = '0'
report "Next state s0, correct outputs: door = 1 and alarm = 0"
severity error;

wait for delay_time - 1 ns; 

--Test case 2: Enter partial correct code at night, then press "O"
reset <= '1';
wait for 1 ns;
assert door = '0' and alarm = '0' 
report "Next state s0, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time - 1 ns;

reset <= '0'; code <= "0010";
assert door = '0' and alarm = '0'
report "Next state s1, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0110";
assert door = '0' and alarm = '0'
report "Next state s2, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1010";
assert door = '0' and alarm = '0'
report "Next state s3, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1101";
wait for 1 ns;
assert door = '0' and alarm = '1'
report "Next state s6, correct outputs: door = 0 and alarm = 1"
severity error;

wait for delay_time - 1 ns;

-- Test case 3: Press "O" directly in daylight
daytime <= '1'; reset <= '1';
wait for 1 ns;
assert door = '0' and alarm = '0' 
report "Next state s0, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time - 1 ns;

reset <= '0'; code <= "1101";
wait for 1 ns;
assert door = '1' and alarm = '0'
report "Next state s0, correct outputs: door = 1 and alarm = 0"
severity error;

wait for delay_time - 1 ns;

-- Test case 4: Enter full correct code at daylight, then press "O"
reset <= '1';
wait for 1 ns;
assert door = '0' and alarm = '0' 
report "Next state s0, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time - 1 ns;

reset <= '0'; code <= "0010";
assert door = '0' and alarm = '0'
report "Next state s7, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0110";
assert door = '0' and alarm = '0'
report "Next state s8, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1010";
assert door = '0' and alarm = '0'
report "Next state s9, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0000";
assert door = '0' and alarm = '0'
report "Next state s10, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0101";
assert door = '0' and alarm = '0'
report "Next state s11, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1101";
wait for 1 ns;
assert door = '1' and alarm = '0'
report "Next state s0, correct outputs: door = 1 and alarm = 0"
severity error;

wait for delay_time - 1 ns;

-- Test case 5: Enter partial correct code at daylight, then press "O"
reset <= '1';
wait for 1 ns;
assert door = '0' and alarm = '0' 
report "Next state s0, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time - 1 ns;

reset <= '0'; code <="0010";
assert door = '0' and alarm = '0'
report "Next state s7, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0110";
assert door = '0' and alarm = '0'
report "Next state s8, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1010";
assert door = '0' and alarm = '0'
report "Next state s9, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0000";
assert door = '0' and alarm = '0'
report "Next state s10, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1101";
wait for 1 ns;
assert door = '1' and alarm = '0'
report "Next state s0, correct outputs: door = 1 and alarm = 0"
severity error;

wait for delay_time - 1 ns;

-- Test case 6: Enter partial correct code at daylight, then reset
reset <= '1';
wait for 1 ns;
assert door = '0' and alarm = '0' 
report "Next state s0, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time - 1 ns;

reset <= '0'; code <= "0010";
assert door = '0' and alarm = '0'
report "Next state s7, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0110";
assert door = '0' and alarm = '0'
report "Next state s8, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

reset <= '1';
assert door = '0' and alarm = '0' 
report "Next state s0, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

-- Test case 7: Enter partial wrong code at daylight
reset <= '1';
assert door = '0' and alarm = '0' 
report "Next state s0, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

reset <= '0'; code <= "0010";
assert door = '0' and alarm = '0'
report "Next state s7, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "0110";
assert door = '0' and alarm = '0'
report "Next state s8, correct outputs: door = 0 and alarm = 0"
severity error;

wait for delay_time;

code <= "1011";
wait for 1 ns;
assert door = '0' and alarm = '1'
report "Next state s6, correct outputs: door = 0 and alarm = 1"
severity error;

wait for delay_time - 1 ns;

wait;
end process;
end architecture;