% Define time vector for 256 samples
t = 0:255; 
y = sin((2 * pi * t) / 255); 

% Shift the sine wave up by 1 to make all values positive
y1 = y + 1; 

% Scale the sine wave to have an amplitude range from 0 to 127 and round it
y2 = round(127 * y1); 

% Display the lookup table values in decimal
disp('Sine wave lookup table (decimal):');
disp(y2);

% Convert the decimal values to hexadecimal
y3 = dec2hex(y2); 

% Add the "0x" prefix to each hexadecimal value for compatibility with C code
string = strcat(',0x', y3); 

% Display the formatted hexadecimal string
disp('Sine wave lookup table (hexadecimal):');
disp(string);

% plot(y2);
