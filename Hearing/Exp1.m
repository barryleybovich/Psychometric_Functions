%Experiment 1
frequency = [ 2 4 8 16 32 64 128];
ici=1./frequency;
rep=ceil(1./(ici+.0001)); %counts repetitions for 1 second total duration
sample=zeros(2,70); %creates all 70 trials
response=zeros(2,7); %records responses
response(1,:)=ici;
for i=1:7
    sample(1,(i-1)*10+1:i*10)=ici(i); %populates row 1, 10 at a time
    sample(2,(i-1)*10+1:i*10)=rep(i); %populates row 2, 10 at a time
end
sample=sample(:,randperm(70)); %randomizes samples

for i=1:70
    for k=1:sample(2,i)
        sound([1 1],20000); %plays sound with T=.1ms
        pause(sample(1,i));%creates ici
    end
    [rows cols vals]=find(response==sample(1,i)); %finds ici  w/ sample
    r=input('discrete=y, cts=n ','s');
    if (r=='y')
        response(2,cols)=response(2,cols)+1; %if yes, count goes up
    end  
end
%the following lines are used to create linear interpolation
response(2,:)=response(2,:)/10;
up=find(response(2,:)<.5);
up=up(1);
upp=response(2,up);
down=find(response(2,:)>.5);
down=down(length(down));
downn=response(2,down);
slope=(downn-upp)/(response(1,down)-response(1,up));
f0=response(1,down)-((downn-.5)/slope);
clf;
%plot
plot(frequency, response(2,:));
hold on;
xlabel('Frequency (Hz)');
ylabel('Probability Responded ''Discrete''');
title('Psychometric Function of Discrete v. Continuous Clicking');
text(50, .5, strcat('Boundry f_0 = ',num2str(1/f0), 'Hz'));

