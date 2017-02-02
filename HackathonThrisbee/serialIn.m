clear
delete(instrfindall);
serialStream = serial('/dev/tty.usbmodem1412','BaudRate',115200);


fopen(serialStream);
csvChars = fscanf(serialStream);
figure(2)
cla
figure(1)
cla
hold off


maxi = 200;
i = 1;
while 1
    csvChars = fscanf(serialStream);
    read = textscan(csvChars, '%d%d%d%d','delimiter',',');
    if size(read)==[1 4] 
        [holder(i), x(i), y(i), z(i)] = deal(read{:});
        i=i+1;
    end
    pause(0.02);
    person = cleanPasses(holder(:));
    plotPentagram(person);
    if length(person)>2 
        analyseNetwork(person);
    end
    mag =  x(:).^2+y(:).^2+z(:).^2;
    figure(1)
    if i<=maxi
        subplot(221); plot(x,'b'); axis([0 200 -3000 3000]); title('Acceleration in X');
        subplot(222); plot(y,'b'); axis([0 200 -3000 3000]); title('Acceleration in Y');
        subplot(223); plot(z,'b'); axis([0 200 -3000 3000]); title('Acceleration in Z');
        subplot(224); plot(mag,'r'); axis([0 200 0 14000000]); title('Total Acceleration');
    else
        subplot(221); plot(x(i-maxi:i-1),'b'); axis([0 200 -3000 3000]); title('Acceleration in X');
        subplot(222); plot(y(i-maxi:i-1),'b'); axis([0 200 -3000 3000]); title('Acceleration in Y');
        subplot(223); plot(z(i-maxi:i-1),'b'); axis([0 200 -3000 3000]); title('Acceleration in Z');
        subplot(224); plot(mag(i-maxi:i-1),'r'); axis([0 200 0 14000000]); title('Total Acceleeation');
    end
end