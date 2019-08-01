function token_key=ApiCreateToken(api_url,api_endpoint,client_id,client_secret)

RQString=['https://',api_url,'/',api_endpoint,'?grant_type=client_credentials&client_id=',client_id,'&client_secret=',client_secret];
options = weboptions('Timeout',60);
tokendata=webread(RQString,options);
pause(2);
token_key=tokendata.access_token;

end