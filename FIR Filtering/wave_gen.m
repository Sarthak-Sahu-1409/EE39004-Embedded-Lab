t = 0:1/2048:1;

y1 = sin(2*50*pi*t);
y2 = sin(2*100*pi*t);

y3 = y1 + y2;
y3 = y3 / max(abs(y3)); 

sig_fixed = fi(y3, 1, 8, 7);  

y_fixed_shifted = uint8((double(sig_fixed) + 1) * 127.5);  % shift from [-1,1] → [0,255]


plot(t, y_fixed_shifted);

y8 = dec2hex(y_fixed_shifted);
hex_cells = cellstr(y8);
string = strcat(',0x', hex_cells);
final_string = [string{:}];
final_string = final_string(2:end);
disp(final_string);
