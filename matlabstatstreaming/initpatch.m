function initpatch(conn)

%% item
itemsql=table();
item=webread('https://api.stratz.com/api/v1/Item');
item=struct2table(item);
nbitem=width(item);
for i=1:nbitem
    itemadd=item{1,i};
    itemdbadd=table();
    itemdbadd.id=itemadd.id;
    itemdbadd.name{1,1}=itemadd.name;
    if  isfield(itemadd,'displayName')==1
        itemdbadd.displayname{1,1}=itemadd.displayName;
    else
        itemdbadd.displayname{1,1}=itemadd.name;
    end
    itemdbadd.shortname{1,1}=itemadd.shortName;
    if  isfield(itemadd,'image')==1
        itemdbadd.image{1,1}=itemadd.image(1:end-2);
    else
        itemdbadd.image='null';
    end
    if isfield(itemadd,'strat')==1
        itemdbadd.cost=itemadd.stat.cost;
        itemdbadd.secret_shop=itemadd.stat.isSecretShop;
        itemdbadd.side_shop=itemadd.stat.isSideShop;
        itemdbadd.recipe=itemadd.stat.isRecipe;
        itemdbadd.support=itemadd.stat.isSupport;
    else
        itemdbadd.cost=0;
        itemdbadd.secretshop=0;
        itemdbadd.sideshop=0;
        itemdbadd.recipe=0;
        itemdbadd.support=1;
    end
    itemsql=[itemsql;itemdbadd];
end

%% insertion sql
pgsqlexec(conn,'delete from public.item')
insert(conn,'public.item',{'id','name','displayname','shortname','image','cost','secret_shop','side_shop','recipe','support'},itemsql);


%% hero
herosql=table();
hero=struct2table(webread('https://api.opendota.com/api/heroes'));
herosql.id=hero.id;
for i=1:height(hero)
    strhero=hero.name{i,1};
    herosql.name{i,1}=strhero(15:end);
end
herosql.displayname=hero.localized_name;
herosql.primary_attr=hero.primary_attr;
herosql.attack_type=hero.attack_type;

%% insertion sql
pgsqlexec(conn,'delete from public.hero')
insert(conn,'public.item',{'id','name','displayname','primary_attr','attack_type'},itemsql);


end
