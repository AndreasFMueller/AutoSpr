for i := 1 to 46 do 
begin
    powers[i] := 2 * powers[i - 1];
    sum := sum + c[i] * powers[i]
end
