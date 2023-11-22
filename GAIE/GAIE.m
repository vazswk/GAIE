%% mian.m   最终的算法方案
clc;clear all;
input = '.\cover';
output = '.\stego';

rate = 0.4; 
Window = 169;
num = 6;
deta = 0.01;
Th =7;
wet = 10^20;

flist = dir([input '\*.wav']);
flen = length(flist);
fprintf('%s%d\n', 'the num of the files: ',flen); 

for i = 1:flen
   fprintf('%d%s\n',i, ['      processing image: ' flist(i).name]);
   in_file_name = [input '\' flist(i).name];
   out_file_name = [output '\' flist(i).name];

 %% audio data reading       
   [Audio,fs] = (audioread(in_file_name,'native'));
   cover = double(Audio);  
 %% GAIE
   rho = GAIE_cal(cover, Window, num, deta);
   
%% MAS
   rho = MAS(cover, rho, Th, wet);
%% simulate embedding
   stego = EmbeddingSimulator_Audio(cover, rho, rho, rate*numel(cover), false);

   stego = int16(stego); 
   audiowrite(out_file_name,stego,fs);
end




