%Experiment 2 
mean=[.01, .025, .1] ;
jitter=[0,5,10,15, 20,25]/100; %creates jitter percentages
rep=[25 15 5]; %number of repetitions for different means
response=zeros(4,6); %creates response matrix
response(1,:)=jitter(1,:); %first matrix
sample=zeros(1,60); %creates samples array

for exp=1:3 %3 experiments, 1 per mean time
    jitter(2,:)=2*jitter(1,:).*mean(exp); %max jitter per trial
    
for i =1:6
    sample((i-1)*10+1:10*i)=jitter(2,i);%populates samples array
end

for i=1:60;
    z=ceil(rand*length(sample)); %picks random trial in sample
    for k=1:rep(exp)
        sound([1 1],20000); %generates T=.1ms sound
        pause(mean(exp)-sample(1,z) +(rand*sample(1,z))); %random ICI
    end
    [rows cols vals]=find(response==sample(1,z));%finds jitter  w/i sample

    r=input('periodic=n, aperiodic=y ','s');
    if (r=='y')
        response(1+exp,cols)=response(1+exp,cols)+1;%if yes, count goes up
    end  
    sample(:,z)=[];
end 
end
response(1,:)=response(1,:)*10;
response=response/10; %creates probabilities
hold on;
%plots
plot(response(1,:),response(2,:), 'b')
plot(response(1,:),response(3,:),'r');
plot(response(1,:),response(4,:),'g');
xlabel('Jitter Percentage');
ylabel('Probability Responded ''Aperiodic''');
title('Psychometric Function of Periodic v. Aperiodic Clicking');
legend('ICI = 10 ms', 'ICI = 25 ms', 'ICI = 100 ms');