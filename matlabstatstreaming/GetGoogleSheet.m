function data=GetGoogleSheet(spreadsheetID)


RQString=['https://sheets.googleapis.com/v4/spreadsheets/',spreadsheetID,'/values/Player!A1:D5'];
options = weboptions('Timeout',120);
data=webread(RQString,options);

end