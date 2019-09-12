entity doorpass is
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
end entity;

architecture fsm of doorpass is
    type state is
        (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11);
        signal cs : state;
        signal ns : state;
-- Synthesis directives :
-- pragma current_state cs
-- pragma next_state ns
-- pragma clock clk
begin

process(clk)
begin
  if(clk = '1' and clk'event)then
    cs <= ns;
  end if;
end process;

process (cs, code, reset)
  begin
    if (reset='1') then
      door <= '0'; alarm <= '0'; ns <= s0;
    else
      case cs is
        when s0 => if(daytime = '0') then
            if(code = "0010") then
                door <= '0'; alarm <= '0'; ns <= s1;
                else
                    door <= '0'; alarm <= '1'; ns <= s6;
                    end if;
            else
                if(code = "1101") then
                    door <= '1'; alarm <= '0'; ns <= s0;
                else
                    if(code = "0010") then
                        door <= '0'; alarm <= '0'; ns <= s7;
                else 
                    door <= '0'; alarm <= '1'; ns <= s6;
                end if;
                end if;
            end if;
        when s1 =>   
            if(code = "0110") then
                door <= '0'; alarm <= '0'; ns <= s2;
                else
                    door <= '0'; alarm <= '1'; ns <= s6;
                    end if;
        when s2 =>
            if(code = "1010") then
                door <= '0'; alarm <= '0'; ns <= s3;
                else
                    door <= '0'; alarm <= '1'; ns <= s6;
                    end if;
        when s3 =>    
                if(code = "0000") then
                    door <= '0'; alarm <= '0'; ns <= s4;
                    else
                        door <= '0'; alarm <= '1'; ns <= s6;
                        end if;
        when s4 => 
                 if(code = "0101") then
                    door <= '0'; alarm <= '0'; ns <= s5;
                    else
                        door <= '0'; alarm <= '1'; ns <= s6;
                        end if;
        when s5 =>    
                 if(code = "1101") then
                    door <= '1'; alarm <= '0'; ns <= s0;
                    else
                        door <= '0'; alarm <= '1'; ns <= s6;
                        end if;
        when s6 =>
                    door <= '0'; alarm <= '0'; ns <= s0;
        when s7 =>  if(code = "1101") then
                    door <= '1'; alarm <= '0'; ns <= s0;
                    else if(code = "0110") then
                        door <= '0'; alarm <= '0'; ns <= s8;
                        else
                            door <= '0'; alarm <= '1'; ns <= s6;
                            end if;
                    end if;
        when s8 =>  if(code = "1101") then
                    door <= '1'; alarm <= '0'; ns <= s0;
                    else if(code = "1010") then
                         door <= '0'; alarm <= '0'; ns <= s9;
                        else
                             door <= '0'; alarm <= '1'; ns <= s6;
                            end if;
                    end if;
        when s9 =>  if(code = "1101") then
                    door <= '1'; alarm <= '0'; ns <= s0;
                    else if(code = "0000") then
                         door <= '0'; alarm <= '0'; ns <= s10;
                        else
                            door <= '0'; alarm <= '1'; ns <= s6;
                            end if;
                    end if;
        when s10 => if(code = "1101") then
                    door <= '1'; alarm <= '0'; ns <= s0;   
                    else if(code = "0101") then
                         door <= '0'; alarm <= '0'; ns <= s11;
                        else
                            door <= '0'; alarm <= '1'; ns <= s6;
                            end if;
                    end if;
        when s11 => 
                    if(code = "1101") then
                         door <= '1'; alarm <= '0'; ns <= s0;
                        else
                            door <= '0'; alarm <= '1'; ns <= s6;
                            end if;
       end case ;
       end if;    
  end process;
end architecture;