function [Table_presence,Table_phase1,Table_phase2,Table_phase3] = Table_Draft(ContextMatch,Hero)
% % % /define phase type
% phase_number=3;
% ban_list=[2,2,1];
% ban_size=5;
% phase_list=[2,2,1];
% % % \define phase type

% % % /define nombre de match à traiter
taille=length(ContextMatch.id_tn);
% % % \define nombre de match à traiter

% % % /initialise var
ban1=[];ban2=[];ban3=[];ban4=[];ban5=[];ban1bis=[];ban2bis=[];ban3bis=[];ban4bis=[];ban5bis=[];
pick1=[];pick2=[];pick3=[];pick4=[];pick5=[];pick1bis=[];pick2bis=[];pick3bis=[];pick4bis=[];pick5bis=[];
for i=1:taille
    % for i=nb_t+1:taille
    if ContextMatch.isfp==0
        % radiant fp si 0, dire si 1
        ban1=[ban1;ContextMatch.BanR1(i)];ban2=[ban2;ContextMatch.BanR2(i)];ban3=[ban3;ContextMatch.BanR3(i)];ban4=[ban4;ContextMatch.BanR4(i)];ban5=[ban5;ContextMatch.BanR5(i)];
        ban1bis=[ban1bis;ContextMatch.BanD1(i)];ban2bis=[ban2bis;ContextMatch.BanD2(i)];ban3bis=[ban3bis;ContextMatch.BanD3(i)];ban4bis=[ban4bis;ContextMatch.BanD4(i)];ban5bis=[ban5bis;ContextMatch.BanD5(i)];
        
        pick1=[pick1;ContextMatch.PickR1(i)];pick2=[pick2;ContextMatch.PickR2(i)];pick3=[pick3;ContextMatch.PickR3(i)];pick4=[pick4;ContextMatch.PickR4(i)];pick5=[pick5;ContextMatch.PickR5(i)];
        pick1bis=[pick1bis;ContextMatch.PickD1(i)];pick2bis=[pick2bis;ContextMatch.PickD2(i)];pick3bis=[pick3bis;ContextMatch.PickD3(i)];pick4bis=[pick4bis;ContextMatch.PickD4(i)];pick5bis=[pick5bis;ContextMatch.PickD5(i)];
    else
        ban1=[ban1;ContextMatch.BanD1(i)];ban2=[ban2;ContextMatch.BanD2(i)];ban3=[ban3;ContextMatch.BanD3(i)];ban4=[ban4;ContextMatch.BanD4(i)];ban5=[ban5;ContextMatch.BanD5(i)];
        ban1bis=[ban1bis;ContextMatch.BanR1(i)];ban2bis=[ban2bis;ContextMatch.BanR2(i)];ban3bis=[ban3bis;ContextMatch.BanR3(i)];ban4bis=[ban4bis;ContextMatch.BanR4(i)];ban5bis=[ban5bis;ContextMatch.BanR5(i)];
        
        pick1=[pick1;ContextMatch.PickD1(i)];pick2=[pick2;ContextMatch.PickD2(i)];pick3=[pick3;ContextMatch.PickD3(i)];pick4=[pick4;ContextMatch.PickD4(i)];pick5=[pick5;ContextMatch.PickD5(i)];
        pick1bis=[pick1bis;ContextMatch.PickR1(i)];pick2bis=[pick2bis;ContextMatch.PickR2(i)];pick3bis=[pick3bis;ContextMatch.PickR3(i)];pick4bis=[pick4bis;ContextMatch.PickR4(i)];pick5bis=[pick5bis;ContextMatch.PickR5(i)];
    end
end

% ban=table(ban1,ban1bis,ban2,ban2bis,ban3,ban3bis,ban4,ban4bis,ban5,ban5bis);
% pick=table(pick1,pick1bis,pick2,pick2bis,pick3,pick3bis,pick4,pick4bis,pick5,pick5bis);


% ban=[ban;ban_temp];
% pick=[pick;pick_temp];
% nb_t=taille;

present_temp=[ban1,ban1bis,ban2,ban2bis,ban3,ban3bis,ban4,ban4bis,ban5,ban5bis,pick1,pick1bis,pick2,pick2bis,pick3,pick3bis,pick4,pick4bis,pick5,pick5bis];
present=unique(present_temp);
present_g=present(present<=24);
present_d=present(present>24);
Nom=Hero.Nom(present_g);Nom=[Nom;Hero.Nom(present_d-1)]; ID=Hero.ID(present_g); ID=[ID;Hero.ID(present_d-1)];
taille2=length(ID);

% % % /première table
presence=zeros(taille2,1);banned=zeros(taille2,1);picked=zeros(taille2,1);
for i=1:taille2
    banned(i)=sum(sum(present_temp(:,1:10)==ID(i)));
    picked(i)=sum(sum(present_temp(:,11:20)==ID(i)));
    presence(i)=picked(i)+banned(i);
end
[presence,order]=sort(presence,'descend');
banned=banned(order);
picked=picked(order);

presence_pourcent=presence*100/taille;
picked_pourcent=picked*100/taille;
banned_pourcent=banned*100/taille;

ID=ID(order);
Nom=Nom(order);

Table_presence=table(ID,Nom,presence_pourcent,presence,picked_pourcent,picked,banned_pourcent,banned);
% % % \première table

% % % /deuxième table
presence=zeros(taille2,1);banned=zeros(taille2,1);picked=zeros(taille2,1);
for i=1:taille2
    
    banned(i)=sum(sum(present_temp(:,1:4)==ID(i)));
    picked(i)=sum(sum(present_temp(:,11:14)==ID(i)));
    presence(i)=picked(i)+banned(i);
end


presence_pourcent=presence*100/taille;
picked_pourcent=picked*100/taille;
banned_pourcent=banned*100/taille;


Table_phase1=table(ID,Nom,presence_pourcent,presence,banned_pourcent,banned,picked_pourcent,picked);
% % % \deuxième table

% % % /troisième table
presence=zeros(taille2,1);banned=zeros(taille2,1);picked=zeros(taille2,1);
for i=1:taille2
    
    banned(i)=sum(sum(present_temp(:,5:8)==ID(i)));
    picked(i)=sum(sum(present_temp(:,15:18)==ID(i)));
    presence(i)=picked(i)+banned(i);
end

presence_pourcent=presence*100/taille;
picked_pourcent=picked*100/taille;
banned_pourcent=banned*100/taille;



Table_phase2=table(ID,Nom,presence_pourcent,presence,banned_pourcent,banned,picked_pourcent,picked);
% % % \troisième table

% % % /quatrième table
presence=zeros(taille2,1);banned=zeros(taille2,1);picked=zeros(taille2,1);
for i=1:taille2
    
    banned(i)=sum(sum(present_temp(:,9:10)==ID(i)));
    picked(i)=sum(sum(present_temp(:,19:20)==ID(i)));
    presence(i)=picked(i)+banned(i);
end

presence_pourcent=presence*100/taille;
picked_pourcent=picked*100/taille;
banned_pourcent=banned*100/taille;


Table_phase3=table(ID,Nom,presence_pourcent,presence,banned_pourcent,banned,picked_pourcent,picked);
% % % \quatrième table