function gmail_send(messageftv,recipients)

setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail','f.turgis@gmail.com');
setpref('Internet','SMTP_Username','f.turgis@gmail.com');
setpref('Internet','SMTP_Password','FTShiBa01');
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
message=['Bonjours Admin FTV',10,10,messageftv,10,10,'Cordialement',10,10,'Votre serviteur ShiBaBot',10,10,'Le Guadian des tournois FTV'];
sendmail(recipients,'Rapport ShiBoBot',message);

end